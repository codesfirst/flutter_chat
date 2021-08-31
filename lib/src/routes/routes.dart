import 'package:flutter/material.dart';
import 'package:flutter_chat/src/pages/login_page.dart';
import 'package:flutter_chat/src/pages/register_page.dart';

Map<String, Widget Function(BuildContext)> getRoutes() => {
  LoginPage.routeName: (_) => LoginPage(),
  RegisterPage.routeName: (_) => RegisterPage(),
};