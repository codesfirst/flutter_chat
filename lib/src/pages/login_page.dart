import 'package:flutter/material.dart';
import 'package:flutter_chat/src/helpers/show_alert.dart';
import 'package:flutter_chat/src/pages/register_page.dart';
import 'package:flutter_chat/src/pages/user_page.dart';
import 'package:flutter_chat/src/services/auth_service.dart';
import 'package:flutter_chat/src/services/socket_service.dart';
import 'package:flutter_chat/src/utils/responsive.dart';
import 'package:flutter_chat/src/widgets/chat_button.dart';
import 'package:flutter_chat/src/widgets/custom_input.dart';
import 'package:flutter_chat/src/widgets/labels.dart';
import 'package:flutter_chat/src/widgets/logo.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static String routeName = "login";
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.grey[200],
        child: SingleChildScrollView(
          child: Container(
            height: Responsive.of(context).hp(100),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(title: "Login"),
                _Form(),
                Labels(
                  title: "¿No tienes cuenta?",
                  description: "Crea una ahora!",
                  route: RegisterPage.routeName,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late AuthService service;
  late SocketService socket;

  @override
  void initState() {
    service = Provider.of<AuthService>(context, listen: false);
    socket = Provider.of<SocketService>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email,
            hintText: "Email",
            controller: emailController,
            textInputType: TextInputType.emailAddress,
          ),
          CustomInput(
            icon: Icons.lock,
            hintText: "Password",
            controller: passwordController,
            obscureText: true,
          ),
          ChatButton(
            func: authService.authenticate ? null : _process,
            text: "Ingresar",
            height: Responsive.of(context).dp(6),
          ),
        ],
      ),
    );
  }

  _process() async {
    print(emailController.text);
    print(passwordController.text);

    FocusScope.of(context).unfocus();
    final resp = await service.login(
        emailController.text.trim(), passwordController.text.trim());
    if (resp) {
      socket.connect();
      Navigator.pushReplacementNamed(context, UserPage.routeName);
    } else {
      showAlert(context, "Login Incorrecto", "Credenciales invalidas");
    }
  }
}
