import 'package:flutter/material.dart';



// ignore: must_be_immutable
class AppText extends StatelessWidget {
  String? data;
  double? size;
  Color? color;
  FontWeight? fw;
  TextAlign? align;
  AppText({super.key, required this.data, this.size=18, this.color, this.fw,this.align=TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(

      data.toString(),
      textAlign: align,
     // overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: size, color: color,fontWeight: fw),
    );
  }
}