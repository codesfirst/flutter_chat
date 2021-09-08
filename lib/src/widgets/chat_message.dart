import 'package:flutter/material.dart';
import 'package:flutter_chat/src/services/auth_service.dart';
import 'package:flutter_chat/src/widgets/chat_text.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animationController;

  const ChatMessage(
      {Key? key,
      required this.text,
      required this.uid,
      required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: uid == authService.usuario?.uid ? _myMessage() : _noMessage(),
        ),
      ),
    );
  }

  _myMessage() => Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(right: 20, bottom: 5, left: 5),
          decoration: BoxDecoration(
              color: Color(0xff4D9EF6),
              borderRadius: BorderRadius.circular(20)),
          child: ChatText(
            text: text,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      );

  _noMessage() => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.only(right: 5, bottom: 5, left: 20),
          decoration: BoxDecoration(
              color: Color(0XFFE4E5E8),
              borderRadius: BorderRadius.circular(20)),
          child: ChatText(
            text: text,
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
      );
}
