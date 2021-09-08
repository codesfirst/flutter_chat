import 'package:flutter_chat/src/global/environment.dart';
import 'package:flutter_chat/src/models/user_model.dart';
import 'package:flutter_chat/src/models/user_response.dart';
import 'package:flutter_chat/src/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<List<UserModel>> getUsers() async {
    try {
      final resp = await http.get(Uri.parse("${Environment.apiUrl}/usuarios"),
          headers: {'x-token': await AuthService.getToken() ?? ""});
      final userResponse = userResponseFromJson(resp.body);
      return userResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
