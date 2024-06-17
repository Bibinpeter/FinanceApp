import 'package:flutter/material.dart';
import 'package:personalfinanceapp/models/user_model.dart';
import 'package:personalfinanceapp/services/auth_service.dart';
import 'package:personalfinanceapp/widgets/apptext.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
      final authService = Provider.of<AuthService>(context);
    return   Scaffold(
           body: FutureBuilder<UserModel?>(
            future: authService.getcurrentUser(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
              }else{
                if(snapshot.hasData){
                  final userData=snapshot.data;
                  return Center(
                    child: AppText(data: "${userData!.name}",color: Colors.white,)
                  );
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            }
            
            
            ),
      );
  }
}