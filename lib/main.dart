import 'package:flutter/material.dart';
import 'package:flutter_chat/src/pages/login_page.dart';
import 'package:flutter_chat/src/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginPage.routeName,
      routes: getRoutes(),
    );
  }
}