// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  int value;
  String message;
  String username;
  String nama;
  String id;

  Login({
    required this.value,
    required this.message,
    required this.username,
    required this.nama,
    required this.id,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    value: json["value"],
    message: json["message"],
    username: json["username"],
    nama: json["nama"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "username": username,
    "nama": nama,
    "id": id,
  };
}
