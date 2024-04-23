// To parse this JSON data, do
//
//     final register2 = register2FromJson(jsonString);

import 'dart:convert';

Register2 register2FromJson(String str) => Register2.fromJson(json.decode(str));

String register2ToJson(Register2 data) => json.encode(data.toJson());

class Register2 {
  int value;
  String message;

  Register2({
    required this.value,
    required this.message,
  });

  factory Register2.fromJson(Map<String, dynamic> json) => Register2(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
