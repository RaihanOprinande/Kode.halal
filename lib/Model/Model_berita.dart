// To parse this JSON data, do
//
//     final berita = beritaFromJson(jsonString);

import 'dart:convert';

Berita beritaFromJson(String str) => Berita.fromJson(json.decode(str));

String beritaToJson(Berita data) => json.encode(data.toJson());

class Berita {
  bool isSuccess;
  String message;
  List<Datum> data;

  Berita({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory Berita.fromJson(Map<String, dynamic> json) => Berita(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String judul;
  String konten;
  String gambar;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.judul,
    required this.konten,
    required this.gambar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    judul: json["judul"],
    konten: json["konten"],
    gambar: json["gambar"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "konten": konten,
    "gambar": gambar,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
