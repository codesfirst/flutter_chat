import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat/src/utils/responsive.dart';
import 'package:flutter_chat/src/widgets/chat_text.dart';

showAlert(BuildContext context, String title, String subTitle) {
  if (Platform.isAndroid)
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title:
                  ChatText(text: title, fontSize: Responsive.of(context).dp(2)),
              content: ChatText(
                  text: subTitle, fontSize: Responsive.of(context).dp(1.5)),
              actions: [
                MaterialButton(
                    textColor: Colors.white,
                    color: Colors.blueAccent,
                    child: ChatText(
                        text: "OK", fontSize: Responsive.of(context).dp(2)),
                    onPressed: () => Navigator.pop(context))
              ],
            ));
  showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
            title:
                ChatText(text: title, fontSize: Responsive.of(context).dp(2)),
            content: ChatText(
                text: subTitle, fontSize: Responsive.of(context).dp(1.5)),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                isDefaultAction: true,
                child: ChatText(
                    text: "OK", fontSize: Responsive.of(context).dp(2)),
              )
            ],
          ));
}
