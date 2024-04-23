// To parse this JSON data, do
//
//     final addPegawai = addPegawaiFromJson(jsonString);

import 'dart:convert';

AddPegawai addPegawaiFromJson(String str) => AddPegawai.fromJson(json.decode(str));

String addPegawaiToJson(AddPegawai data) => json.encode(data.toJson());

class AddPegawai {
  int value;
  String message;

  AddPegawai({
    required this.value,
    required this.message,
  });

  factory AddPegawai.fromJson(Map<String, dynamic> json) => AddPegawai(
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
  };
}
