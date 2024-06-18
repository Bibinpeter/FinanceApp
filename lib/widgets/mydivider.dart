import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8.0,top: 16),
      child: Divider(
        height: 1.3, 
        color: Color.fromARGB(255, 0, 140, 255)
      ),
    );
  }
}