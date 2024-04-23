// To parse this JSON data, do
//
//     final updatePegawai = updatePegawaiFromJson(jsonString);

import 'dart:convert';

UpdatePegawai updatePegawaiFromJson(String str) => UpdatePegawai.fromJson(json.decode(str));

String updatePegawaiToJson(UpdatePegawai data) => json.encode(data.toJson());

class UpdatePegawai {
  bool isSuccess;
  int value;
  String message;
  Data data;

  UpdatePegawai({
    required this.isSuccess,
    required this.value,
    required this.message,
    required this.data,
  });

  factory UpdatePegawai.fromJson(Map<String, dynamic> json) => UpdatePegawai(
    isSuccess: json["is_success"],
    value: json["value"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "is_success": isSuccess,
    "value": value,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String nama;
  String nobp;
  String nohp;
  String email;
  String tanggalInput;

  Data({
    required this.id,
    required this.nama,
    required this.nobp,
    required this.nohp,
    required this.email,
    required this.tanggalInput,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    nama: json["nama"],
    nobp: json["nobp"],
    nohp: json["nohp"],
    email: json["email"],
    tanggalInput: json["tanggal_input"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "nobp": nobp,
    "nohp": nohp,
    "email": email,
    "tanggal_input": tanggalInput,
  };
}
