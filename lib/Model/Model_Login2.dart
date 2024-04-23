// To parse this JSON data, do
//
//     final login2 = login2FromJson(jsonString);

import 'dart:convert';

Login2 login2FromJson(String str) => Login2.fromJson(json.decode(str));

String login2ToJson(Login2 data) => json.encode(data.toJson());

class Login2 {
  int value;
  String message;
  String username;
  String fullname;
  String id;

  Login2({
    required this.value,
    required this.message,
    required this.username,
    required this.fullname,
    required this.id,
  });

  factory Login2.fromJson(Map<String, dynamic> json) => Login2(
    value: json["value"],
    message: json["message"],
    username: json["username"],
    fullname: json["fullname"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "username": username,
    "fullname": fullname,
    "id": id,
  };
}
