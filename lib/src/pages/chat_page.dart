import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/src/models/message_model.dart';
import 'package:flutter_chat/src/utils/responsive.dart';
import 'package:flutter_chat/src/widgets/chat_message.dart';
import 'package:flutter_chat/src/widgets/chat_text.dart';

class ChatPage extends StatefulWidget {
  static String routeName = "chat";
  ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;
  List<ChatMessage> _messageList = [
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[200],
                child: ChatText(text: "PE", fontSize: Responsive.of(context).dp(1)),
                maxRadius: Responsive.of(context).dp(1.2),
              ),
              ChatText(text: "Peter Herrera", fontSize: Responsive.of(context).dp(1.2))
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: _messageList.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, i) => _messageList[i],
                reverse: true,
              )
            ),
            Divider(),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  _inputChat() => SafeArea(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.of(context).dp(1.5)),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              onSubmitted: (text){
                _submitted(text);
              },
              onChanged: (text){
                setState(() {
                  if(text.trim().length > 0) _isWriting = true;
                  else _isWriting = false;
                });
              },
              controller: _textController,
              decoration: InputDecoration.collapsed(
                hintText: "Enviar mensaje"
              ),
              focusNode: _focusNode,
            )
          ),
          Container(
            child: !Platform.isIOS 
              ? CupertinoButton(
                onPressed: _isWriting ? () => _submitted(_textController.text.trim()): null,
                child: ChatText(text: "Enviar", fontSize: Responsive.of(context).dp(2),), 
              )
              : Container(
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400]),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: _isWriting ? () => _submitted(_textController.text.trim()): null, 
                    icon: Icon(Icons.send)
                  ),
                ),
              ),
          )
        ],
      ),
    ),
  );

  void _submitted(String text) {
    if(text.length == 0) return;
    print(text);
    final messageModel = ChatMessage(text: text, uid: "123", animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 300)),);
    _messageList.insert(0, messageModel);
    messageModel.animationController.forward();
    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    _messageList.forEach((element) {
      element.animationController.dispose();
    });
    super.dispose();
  }

  //0xFF4D9EF6
  //
}