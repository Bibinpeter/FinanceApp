import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthService with ChangeNotifier {
  Box<UserModel>? _userBox;
  static const String _loggedInKey = 'isLoggedIn';

  Future<void> openBox() async {
    _userBox = await Hive.openBox<UserModel>('users');
    print('Box opened: $_userBox');
  }

  // Register user
  Future<bool> registerUser(UserModel user) async {
    if (_userBox == null) {
      await openBox();
    }

    await _userBox?.add(user);
    notifyListeners();
    print("User registered successfully");
    return true;
  }

  // Login
  Future<UserModel?> loginUser(String email, String password) async {
    if (_userBox == null) {
      await openBox();
    }
    for (var user in _userBox!.values) {
      if (user.email == email && user.password == password) {
        await setLoggedInState(true, user.id);
        return user;
      }
    }
    return null;
  }

  Future<void> setLoggedInState(bool isLoggedIn, String id) async {
    final _pref = await SharedPreferences.getInstance();
    await _pref.setBool(_loggedInKey, isLoggedIn);
    await _pref.setString('id', id);
    print("Logged in state set to $isLoggedIn for user $id");
  }

  Future<bool> isUserLoggedIn() async {
    final _pref = await SharedPreferences.getInstance();
    return _pref.getBool(_loggedInKey) ?? false;
  }

  Future<UserModel?> getCurrentUser() async {
    if (_userBox == null) {
      await openBox();
    }

    final isLoggedIn = await isUserLoggedIn();
    print('Is user logged in: $isLoggedIn');
    if (isLoggedIn) {
      final loggedInUserId = await getCurrentUserId();
      print('Logged in user ID: $loggedInUserId');
      if (loggedInUserId != null && _userBox != null) {
        for (var user in _userBox!.values) {
          if (user.id == loggedInUserId) {
            print('User found: ${user.name}');
            return user;
          }
        }
      }
    }
    print('No user found');
    return null;
  }

  Future<String?> getCurrentUserId() async {
    final _pref = await SharedPreferences.getInstance();
    final id = _pref.getString("id");
    print("Current user ID from preferences: $id");
    return id;
  }

  Future<bool> logOut() async {
    final _pref = await SharedPreferences.getInstance();
    await _pref.clear();
    print("User logged out and preferences cleared");
    return true;
  }
}
