import 'package:flutter/material.dart';
import 'package:flutter_chat/src/global/environment.dart';
import 'package:flutter_chat/src/services/auth_service.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_chat/src/models/user_model.dart';
import 'package:flutter_chat/src/models/mensaje_response.dart';

class ChatService with ChangeNotifier {
  UserModel? userFor;

  Future<List<Mensaje>> getChats(String from) async {
    try {
      final result = await http
          .get(Uri.parse("${Environment.apiUrl}/mensajes/$from"), headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken() ?? ""
      });

      final mensajeResponse = mensajeResponseFromJson(result.body);
      return mensajeResponse.mensajes;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
