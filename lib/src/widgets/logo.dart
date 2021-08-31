import 'package:flutter/material.dart';
import 'package:flutter_chat/src/utils/responsive.dart';
import 'package:flutter_chat/src/widgets/chat_text.dart';

class Logo extends StatelessWidget {
  final String title;
  const Logo({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.of(context).wp(50),
      padding: EdgeInsets.symmetric(horizontal: Responsive.of(context).dp(3),),
      margin: EdgeInsets.only(top: Responsive.of(context).dp(2)),
      child: Column(
        children: [
          Container(child: Image.asset("assets/tag-logo.png")),
          SizedBox(height: Responsive.of(context).dp(1.5),),
          ChatText(
            text: title, 
            fontSize: Responsive.of(context).dp(3)),
        ],
      ),
    );
  }
}