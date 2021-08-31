import 'package:flutter/material.dart';

class ChatText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  
  const ChatText({
    Key? key,
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text, 
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}