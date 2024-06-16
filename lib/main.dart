import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personalfinanceapp/constants/colors.dart';
import 'package:personalfinanceapp/models/user_model.dart';
import 'package:personalfinanceapp/screens/Loginpage.dart';
import 'package:personalfinanceapp/screens/home.dart';
import 'package:personalfinanceapp/screens/register_page.dart';
import 'package:personalfinanceapp/screens/splash_page.dart';
import 'package:personalfinanceapp/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
   await AuthService().openBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (context)=>AuthService())
        
        
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldColor,
          textTheme: TextTheme(displaySmall: TextStyle(color: Colors.white,fontSize: 16))
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
        'login':(context) =>LoginPage(),
        'register':(context) =>RegisterPage(),
         'Home':(context) =>Home(),    
        },
      ),
    );
  }
}
