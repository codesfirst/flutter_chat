import 'package:flutter/material.dart';
import 'package:flutter_chat/src/pages/chat_page.dart';

import 'package:flutter_chat/src/pages/user_page.dart';
import 'package:flutter_chat/src/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: ChatPage.routeName,
      routes: getRoutes(),
    );
  }
}