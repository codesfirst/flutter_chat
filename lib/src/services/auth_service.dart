import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chat/src/models/login_response.dart';
import 'package:flutter_chat/src/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_chat/src/global/environment.dart';

class AuthService with ChangeNotifier {
  UserModel? usuario;
  bool _isAuthenticate = false;
  bool get authenticate => this._isAuthenticate;
  // Create storage
  final _storage = new FlutterSecureStorage();

  set authenticate(bool value) {
    this._isAuthenticate = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    final storage = new FlutterSecureStorage();
    return await storage.read(key: "token");
  }

  static Future<void> deleteToken() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: "token");
  }

  Future<bool> login(String email, String password) async {
    bool isCorrect = false;
    this.authenticate = true;
    final data = {
      'email': email,
      'password': password,
    };
    final resp = await http.post(Uri.parse("${Environment.apiUrl}/login"),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    if (resp.statusCode == 200) {
      final usuario = loginResponseFromJson(resp.body);
      this.usuario = usuario.usuario;
      print(usuario.token);
      this._saveToken(usuario.token);
      isCorrect = true;
    }
    this.authenticate = false;
    return isCorrect;
  }

  Future<bool> reNew() async {
    bool isCorrect = false;
    final token = await this._storage.read(key: "token");
    final resp = await http.get(Uri.parse("${Environment.apiUrl}/login/renew"),
        headers: {'Content-Type': 'application/json', 'x-token': token ?? ""});

    print(resp.body);
    if (resp.statusCode == 200) {
      final usuario = loginResponseFromJson(resp.body);
      print(usuario.token);
      this.usuario = usuario.usuario;
      this._saveToken(usuario.token);
      isCorrect = true;
    } else {
      this.logout();
    }

    return isCorrect;
  }

  Future<bool> register(String name, String email, String password) async {
    bool isCorrect = false;
    this.authenticate = true;
    final data = {
      'nombre': name,
      'email': email,
      'password': password,
    };
    final resp = await http.post(Uri.parse("${Environment.apiUrl}/login/new"),
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});

    print(resp.body);
    if (resp.statusCode == 200) {
      final usuario = loginResponseFromJson(resp.body);
      print(usuario.token);
      this.usuario = usuario.usuario;
      this._saveToken(usuario.token);
      isCorrect = true;
    }
    this.authenticate = false;
    return isCorrect;
  }

  _saveToken(String? token) async {
    // Write value
    await _storage.write(key: "token", value: token);
  }

  Future<void> logout() async {
    await _storage.delete(key: "token");
  }
}
