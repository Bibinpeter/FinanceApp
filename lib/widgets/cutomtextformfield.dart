import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final bool readOnly;
  final TextEditingController controller;
  final TextStyle? hintstyle;

  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final TextStyle?errorStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  // ignore: prefer_typing_uninitialized_variables
  final type;
  final String? value;
  final TextStyle? style;
  // ignore: prefer_typing_uninitialized_variables
  final maxlines;
  const CustomTextFormField({
    super.key,
    this.hintstyle,
    this.errorStyle,
    this.readOnly=false,
    this.style,
    required this.controller,
    this.maxlines=1,
    this.type=TextInputType.text,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.enabledBorder,
    this.focusedBorder,
    this.prefixIcon,
    this.suffixIcon,
    this.value,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
    initialValue: widget.value,
      readOnly: widget.readOnly,
      style:Theme.of(context).textTheme.displaySmall ,
      maxLines: widget.maxlines,
      keyboardType: widget.type,
      controller: widget.controller,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.red.shade300),
        hintStyle: const TextStyle(color: Colors.white60,fontSize: 12),
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.white)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white)
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.obscureText ? IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,color: Colors.white,),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ) : widget.suffixIcon,
      ),
      obscureText: widget.obscureText && _obscureText,
      validator: widget.validator,
    );
  }
}