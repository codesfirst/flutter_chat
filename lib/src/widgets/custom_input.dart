import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final bool obscureText;

  const CustomInput({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.obscureText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0,1.5),
            blurRadius: 3,
          )
        ]
      ),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        autocorrect: false,
        keyboardType: textInputType,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText
        ),
      ),
    );
  }
}