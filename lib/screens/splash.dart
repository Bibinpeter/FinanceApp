import 'dart:async';

import 'package:flutter/material.dart';
import 'package:personalfinanceapp/services/auth_service.dart';
import 'package:provider/provider.dart';

 
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _Splash_PageState();
}

// ignore: camel_case_types
class _Splash_PageState extends State<SplashPage> {

  @override
  void initState(){
    checkLoginState();
    super.initState();
  }



  Future<void>checkLoginState()async{
    await Future.delayed(const Duration(seconds: 4));
    // ignore: use_build_context_synchronously
    final authService=Provider.of<AuthService>(context,listen: false);
    final isLoggedIn=await authService.isUserLoggedIn();
     if(isLoggedIn){
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, 'Home',(routes)=>false);
     }else{
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context,'login');
     }
  }





  // ignore: annotate_overrides
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