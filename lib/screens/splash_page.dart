import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _Splash_PageState();
}

class _Splash_PageState extends State<SplashPage> {

  @override
  void initState(){
    checkLoginState();
    super.initState();
  }



  Future<void>checkLoginState()async{
    await Future.delayed(Duration(seconds: 4));
    final authService=Provider.of<AuthService>(context,listen: false);
    final isLoggedIn=await authService.isUserLoggedIn();
     if(isLoggedIn){
      Navigator.pushNamedAndRemoveUntil(context, 'Home',(routes)=>false);
     }else{
      Navigator.pushReplacementNamed(context,'login');
     }
  }





  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Image.asset('assets/img/logo.png',height: 100,width: 180,)
          ],
         ),
      ),
    );
  }
}