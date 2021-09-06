import 'package:flutter/material.dart';
import 'package:flutter_chat/src/utils/responsive.dart';
import 'package:flutter_chat/src/widgets/chat_text.dart';

class ChatButton extends StatelessWidget {
  final String text;
  final Color color;
  final double height;
  final Function()? func;

  const ChatButton({
    Key? key,
    this.func,
    required this.text,
    this.color = Colors.blue,
    this.height = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        elevation: 2,
        highlightElevation: 5,
        shape: StadiumBorder(),
        color: color,
        onPressed: func,
        disabledColor: Colors.black54,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: height,
          child: ChatText(
            text: text,
            fontSize: Responsive.of(context).dp(2),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
