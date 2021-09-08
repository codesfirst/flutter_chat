import 'package:flutter/material.dart';
import 'package:flutter_chat/src/models/user_model.dart';
import 'package:flutter_chat/src/pages/chat_page.dart';
import 'package:flutter_chat/src/pages/login_page.dart';
import 'package:flutter_chat/src/services/auth_service.dart';
import 'package:flutter_chat/src/services/chat_service.dart';
import 'package:flutter_chat/src/services/socket_service.dart';
import 'package:flutter_chat/src/services/user_service.dart';
import 'package:flutter_chat/src/utils/responsive.dart';
import 'package:flutter_chat/src/widgets/chat_text.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserPage extends StatefulWidget {
  static String routeName = "user";

  UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _refreshController = RefreshController(initialRefresh: false);
  final _userService = new UserService();
  List<UserModel> userList = [];

  @override
  void initState() {
    _loadUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<AuthService>(context);
    final socket = Provider.of<SocketService>(context);
    final user = service.usuario;
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
              onPressed: () {
                socket.disconnect();
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
                AuthService.deleteToken();
              },
              icon: Icon(
                Icons.exit_to_app_outlined,
                color: Colors.blue,
              )),
        ),
        backgroundColor: Colors.white,
        title: Center(
            child: ChatText(
                text: "${user?.name}", fontSize: Responsive.of(context).dp(2))),
        actions: [
          socket.serverStatus == ServerStatus.Online
              ? Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                )
              : Icon(
                  Icons.offline_bolt_outlined,
                  color: Colors.red,
                ),
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check_circle_outline,
            color: Colors.blue[400],
          ),
          waterDropColor: Colors.blue,
        ),
        onRefresh: _loadUser,
        controller: _refreshController,
        child: _listViewUser(),
      ),
    );
  }

  Container _listViewUser() {
    return Container(
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: userList.length,
        separatorBuilder: (_, i) => Divider(),
        itemBuilder: (_, i) => _userListTile(userList[i]),
      ),
    );
  }

  ListTile _userListTile(UserModel user) => ListTile(
        title:
            ChatText(text: user.name, fontSize: Responsive.of(context).dp(2)),
        subtitle: ChatText(
            text: user.email, fontSize: Responsive.of(context).dp(1.5)),
        leading: CircleAvatar(
            backgroundColor: Colors.blue[200],
            child: ChatText(
              text: user.name.substring(0, 2),
              fontSize: Responsive.of(context).dp(1.5),
              color: Colors.white,
            )),
        trailing: Container(
          height: Responsive.of(context).dp(0.5),
          width: Responsive.of(context).dp(0.5),
          decoration: BoxDecoration(
              color: user.isOnline ? Colors.green : Colors.red,
              borderRadius:
                  BorderRadius.circular(Responsive.of(context).dp(2))),
        ),
        onTap: () {
          final userFor = Provider.of<ChatService>(context, listen: false);
          userFor.userFor = user;
          Navigator.pushNamed(context, ChatPage.routeName);
        },
      );

  void _loadUser() async {
    final users = await _userService.getUsers();
    this.userList = users;
    setState(() {});

    // monitor network fetch
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
