import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthService with ChangeNotifier {
  Box<UserModel>? _userBox;
  static const String _loggedInKey = 'isLoggedIn';

   Future<void> openBox() async {
  _userBox = await Hive.openBox<UserModel>('users'); // Ensure the type is UserModel
}


  // register user

  Future<bool> registerUser(UserModel user) async {
    if (_userBox == null) {
      await openBox();
    }

    await _userBox?.add(user);
    notifyListeners();
    print("successssssssssssssssssssssssssss");
    return true;
  }


  //login

  Future<UserModel?>loginUser(String email,String password,)async{
    if(_userBox==null){
      await openBox();
    }
    for (var user in _userBox!.values){
      if(user.email==email && user.password==password){
        await setLoggedInState(true,user.id);

        return user;
      }

    }
    return null;
  }


  Future<void>setLoggedInState(bool isLoggedIn,String id)async{
  final _pref= await SharedPreferences.getInstance();
  await _pref.setBool(_loggedInKey, isLoggedIn);
  await _pref.setString('id', id);
  }

  Future<bool>isUserLoggedIn()async{
    final _pref=await SharedPreferences.getInstance();
    return _pref.getBool(_loggedInKey)?? false;
  }

  Future<UserModel?>getcurrentUser()async{
final isLoggedIn=await isUserLoggedIn();
if(isLoggedIn){
  final loggedinUserId=await getCurrentUserId();
  for(var user in _userBox!.values){
    if(user.id==loggedinUserId){
      return user;
    }
  }
}
  }

  Future<String?>getCurrentUserId()async{
    final _pref=await SharedPreferences.getInstance();
    final id=await _pref.getString('id');
    return id;
   }
}