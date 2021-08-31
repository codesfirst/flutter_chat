import 'package:flutter/material.dart';
import 'package:flutter_chat/src/utils/responsive.dart';
import 'package:flutter_chat/src/widgets/chat_text.dart';

class Labels extends StatelessWidget {
  final String route;
  final String title;
  final String description;

  const Labels({Key? key, 
    required this.route, 
    required this.title, 
    required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    child: Column(
      children: [
        ChatText(
          text: title, 
          fontSize: Responsive.of(context).dp(1.3), 
          color: Colors.grey[500] ?? Colors.grey,
        ),
        GestureDetector(
          child: ChatText(
            text: description, 
            fontSize: Responsive.of(context).dp(1.5), 
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
          ),
          onTap: (){
            Navigator.pushReplacementNamed(context, route);
          },
        ),
        SizedBox(height: Responsive.of(context).dp(4),),
        Text("Terminos y condiciones de uso", 
          style: TextStyle(
            fontSize: Responsive.of(context).dp(1.3),
            color: Colors.grey[500]
          ),
        ),
        SizedBox(height: Responsive.of(context).dp(4),),
      ],
    ),
  );;
  }
}