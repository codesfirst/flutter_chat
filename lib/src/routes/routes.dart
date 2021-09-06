import 'package:flutter/material.dart';
import 'package:flutter_chat/src/pages/chat_page.dart';
import 'package:flutter_chat/src/pages/loading_page.dart';
import 'package:flutter_chat/src/pages/login_page.dart';
import 'package:flutter_chat/src/pages/register_page.dart';
import 'package:flutter_chat/src/pages/user_page.dart';

Map<String, Widget Function(BuildContext)> getRoutes() => {
      LoginPage.routeName: (_) => LoginPage(),
      RegisterPage.routeName: (_) => RegisterPage(),
      UserPage.routeName: (_) => UserPage(),
      ChatPage.routeName: (_) => ChatPage(),
      LoadingPage.routeName: (_) => LoadingPage(),
    };
