import 'package:flutter/material.dart';
import 'package:flutter_chat/src/pages/login_page.dart';
import 'package:flutter_chat/src/pages/user_page.dart';
import 'package:flutter_chat/src/services/auth_service.dart';
import 'package:flutter_chat/src/services/socket_service.dart';
import 'package:flutter_chat/src/utils/responsive.dart';
import 'package:flutter_chat/src/widgets/chat_text.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  static String routeName = "loading";

  LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _loadData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Center(
              child: ChatText(
                  text: "Espere...", fontSize: Responsive.of(context).dp(2)),
            );
          },
        ),
      ),
    );
  }

  _loadData() async {
    final service = Provider.of<AuthService>(context, listen: false);
    final socket = Provider.of<SocketService>(context, listen: false);
    final resp = await service.reNew();
    if (resp) {
      socket.connect();
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => UserPage(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginPage(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
