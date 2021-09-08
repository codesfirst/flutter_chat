// To parse this JSON data, do
//
//     final mensajeResponse = mensajeResponseFromJson(jsonString);

import 'dart:convert';

MensajeResponse mensajeResponseFromJson(String str) =>
    MensajeResponse.fromJson(json.decode(str));

String mensajeResponseToJson(MensajeResponse data) =>
    json.encode(data.toJson());

class MensajeResponse {
  MensajeResponse({
    required this.ok,
    required this.mensajes,
  });

  bool ok;
  List<Mensaje> mensajes;

  factory MensajeResponse.fromJson(Map<String, dynamic> json) =>
      MensajeResponse(
        ok: json["ok"],
        mensajes: List<Mensaje>.from(
            json["mensajes"].map((x) => Mensaje.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toJson())),
      };
}

class Mensaje {
  Mensaje({
    required this.from,
    required this.mensajeFor,
    required this.msg,
    required this.createdAt,
    required this.updatedAt,
  });

  String from;
  String mensajeFor;
  String msg;
  DateTime createdAt;
  DateTime updatedAt;

  factory Mensaje.fromJson(Map<String, dynamic> json) => Mensaje(
        from: json["from"],
        mensajeFor: json["for"],
        msg: json["msg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "for": mensajeFor,
        "msg": msg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
