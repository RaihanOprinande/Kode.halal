

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager{

  int? value;
  String? idUser, userName, nama , Email, noHp;
  bool? isSuccess;

  Future<void> saveSession(int val, String id, String userName) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("value", val);
    sharedPreferences.setString("id", id);
    sharedPreferences.setString("username", userName);
  }

  Future  getSession() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    value = sharedPreferences.getInt("value");
    idUser = sharedPreferences.getString("id");
    userName = sharedPreferences.getString("username");
    return value;
  }

  Future  clearSession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}

SessionManager session = SessionManager();