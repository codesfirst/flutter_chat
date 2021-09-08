import 'package:flutter/material.dart';
import 'package:flutter_chat/src/pages/chat_page.dart';
import 'package:flutter_chat/src/pages/loading_page.dart';
import 'package:flutter_chat/src/pages/login_page.dart';
import 'package:flutter_chat/src/routes/routes.dart';
import 'package:flutter_chat/src/services/auth_service.dart';
import 'package:flutter_chat/src/services/chat_service.dart';
import 'package:flutter_chat/src/services/socket_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => SocketService(),
        ),
        ChangeNotifierProvider(create: (_) => ChatService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: LoadingPage.routeName,
        routes: getRoutes(),
      ),
    );
  }
}
