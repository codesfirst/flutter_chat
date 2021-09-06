// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.name,
    required this.email,
    this.isOnline = false,
    required this.uid,
  });

  String name;
  String email;
  bool isOnline;
  String uid;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["nombre"],
        email: json["email"],
        isOnline: json["online"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": name,
        "email": email,
        "online": isOnline,
        "uid": uid,
      };
}
