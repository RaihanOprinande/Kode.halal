import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionUser{

  int? value;
  String? idUser, userName ,nama , email, noHp;

  Future<void> saveSession(int val, String id, String username, String nama, String email, String noHp) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("value", val);
    sharedPreferences.setString("id", id);
    sharedPreferences.setString("nama", nama);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("noHp", noHp);
  }

  Future  getSession() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    value = sharedPreferences.getInt("value");
    idUser = sharedPreferences.getString("id");
    idUser = sharedPreferences.getString("id");
    idUser = sharedPreferences.getString("id");
    idUser = sharedPreferences.getString("id");

    return value;
  }

  Future  clearSession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}

SessionUser session = SessionUser();