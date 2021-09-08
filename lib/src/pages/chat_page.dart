import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/src/models/message_model.dart';
import 'package:flutter_chat/src/services/auth_service.dart';
import 'package:flutter_chat/src/services/chat_service.dart';
import 'package:flutter_chat/src/services/socket_service.dart';
import 'package:flutter_chat/src/utils/responsive.dart';
import 'package:flutter_chat/src/widgets/chat_message.dart';
import 'package:flutter_chat/src/widgets/chat_text.dart';
import 'package:provider/provider.dart';

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
  List<ChatMessage> _messageList = [];

  late ChatService chatService;
  late AuthService authService;
  late SocketService socketService;

  @override
  void initState() {
    chatService = Provider.of<ChatService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('send-private', getData);
    _getChats(chatService.userFor?.uid ?? "");
    super.initState();
  }

  getData(payload) {
    final chatMsg = ChatMessage(
        text: payload['msg'],
        uid: payload['from'],
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 300)));

    _messageList.insert(0, chatMsg);
    setState(() {});
    chatMsg.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[200],
                child: ChatText(
                    text: "${chatService.userFor?.name.substring(0, 2)}",
                    fontSize: Responsive.of(context).dp(1)),
                maxRadius: Responsive.of(context).dp(1.2),
              ),
              ChatText(
                  text: "${chatService.userFor?.name}",
                  fontSize: Responsive.of(context).dp(1.2))
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
            )),
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
          margin:
              EdgeInsets.symmetric(horizontal: Responsive.of(context).dp(1.5)),
          child: Row(
            children: [
              Flexible(
                  child: TextField(
                onSubmitted: (text) {
                  _submitted(text);
                },
                onChanged: (text) {
                  setState(() {
                    if (text.trim().length > 0)
                      _isWriting = true;
                    else
                      _isWriting = false;
                  });
                },
                controller: _textController,
                decoration:
                    InputDecoration.collapsed(hintText: "Enviar mensaje"),
                focusNode: _focusNode,
              )),
              Container(
                child: !Platform.isIOS
                    ? CupertinoButton(
                        onPressed: _isWriting
                            ? () => _submitted(_textController.text.trim())
                            : null,
                        child: ChatText(
                          text: "Enviar",
                          fontSize: Responsive.of(context).dp(2),
                        ),
                      )
                    : Container(
                        child: IconTheme(
                          data: IconThemeData(color: Colors.blue[400]),
                          child: IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: _isWriting
                                  ? () =>
                                      _submitted(_textController.text.trim())
                                  : null,
                              icon: Icon(Icons.send)),
                        ),
                      ),
              )
            ],
          ),
        ),
      );

  void _submitted(String text) {
    if (text.length == 0) return;
    print(text);
    final messageModel = ChatMessage(
      text: text,
      uid: authService.usuario?.uid ?? "",
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 300)),
    );
    _messageList.insert(0, messageModel);
    messageModel.animationController.forward();
    _textController.clear();
    _focusNode.requestFocus();
    setState(() {
      _isWriting = false;
    });

    socketService.emit('send-private', {
      'from': authService.usuario?.uid,
      'for': chatService.userFor?.uid,
      'msg': text
    });
  }

  @override
  void dispose() {
    //socketService.socket.disconnect();
    _messageList.forEach((element) {
      element.animationController.dispose();
    });

    this.socketService.socket.off('mensaje-personal');
    super.dispose();
  }

  _getChats(String uid) async {
    final mensajes = await chatService.getChats(uid);
    final mensaje = mensajes.map((e) => ChatMessage(
        text: e.msg,
        uid: e.from,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 0))
          ..forward()));
    _messageList.insertAll(0, mensaje);
    setState(() {});
  }

  //0xFF4D9EF6
  //
}
