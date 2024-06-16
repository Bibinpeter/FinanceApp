import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _Splash_PageState();
}

class _Splash_PageState extends State<SplashPage> {

  @override
  void initState(){
   Future.delayed(Duration(seconds: 3),(){
    Navigator.pushReplacementNamed(context, 'login');
   });
    super.initState();
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