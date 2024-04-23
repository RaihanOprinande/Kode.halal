import 'package:demouas/Screen%20Page/Bottom_Navigation_Page.dart';
import 'package:demouas/Screen%20Page/List_Edukasi_Page.dart';
import 'package:demouas/Screen%20Page/Login_page.dart';
import 'package:demouas/Screen%20Page/Page_Login2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class PageBeranda extends StatelessWidget {
  const PageBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'gambar/aurora.jpeg',
                fit: BoxFit.contain,
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 8,
              ),
              MaterialButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                =>const loginpage2()
                ));
              },
                color: Colors.green,
                textColor: Colors.white,
                child: const Text('Login',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                ),
              ),
              const SizedBox(height: 5,),
            ],
          ),
        ),
      ),
    );
  }
}