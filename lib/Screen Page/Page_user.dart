import 'package:flutter/material.dart';

import '../Utils/Session_Manager.dart';

class PageUser extends StatefulWidget {
  const PageUser({super.key});

  @override
  State<PageUser> createState() => _PageUserState();
}

class _PageUserState extends State<PageUser> {

  String? userName, name, email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataSession();
  }

  //untuk mendapatkan sesi
  Future getDataSession() async{
    await Future.delayed(const Duration(seconds: 5),(){
      session.getSession().then((value){
        print('Data sesi ..'+ value.toString());
        userName = session.userName;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'username = ${userName}'
        ),
      ),
    );
  }
}
