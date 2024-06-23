import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personalfinanceapp/constants/colors.dart';
import 'package:personalfinanceapp/models/expense_model.dart';
import 'package:personalfinanceapp/models/income_model.dart';
import 'package:personalfinanceapp/models/user_model.dart';
import 'package:personalfinanceapp/screens/add_income.dart';
import 'package:personalfinanceapp/screens/addexpense.dart';
import 'package:personalfinanceapp/screens/auth/Loginpage.dart';
import 'package:personalfinanceapp/screens/auth/register_page.dart';
import 'package:personalfinanceapp/screens/auth/splash_page.dart';
import 'package:personalfinanceapp/screens/home.dart';
import 'package:personalfinanceapp/screens/list_exp_transaction.dart';
import 'package:personalfinanceapp/screens/list_income_transaction.dart';
import 'package:personalfinanceapp/screens/profile_page.dart';
import 'package:personalfinanceapp/services/auth_service.dart';
import 'package:personalfinanceapp/services/finance_service.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(IncomeModelAdapter());
  Hive.registerAdapter(ExpenseModelAdapter());
  await AuthService().openBox();
  await UserService().openIncomeBox();
  await UserService().openExpenseBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => UserService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: scaffoldColor,
            textTheme: const TextTheme(
                displaySmall: TextStyle(color: Colors.white, fontSize: 17))),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          'login': (context) => const LoginPage(),
          'register': (context) => const RegisterPage(),
          'Home': (context) => const HomePage(),
          'addExpense': (context) => const AddExpensePage(),
          'addIncome':(context)=>const AddIncomePage(),
          'profile': (context) => const ProfilePage(),
          'listexpense': (context) => const ListExpenseTransactions()
         , 'listincome': (context) => const ListIncomeTransactions()
        },
      ),
    );
  }
}