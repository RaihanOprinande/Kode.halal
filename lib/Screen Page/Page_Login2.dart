import 'package:demouas/Model/Model_Login2.dart';
import 'package:demouas/Screen%20Page/Bottom_Navigation_Page.dart';
import 'package:demouas/Screen%20Page/Page_Register2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Utils/Session_Manager.dart';
import 'Page_List_Berita.dart';

class loginpage2 extends StatefulWidget {
  const loginpage2({super.key});

  @override
  State<loginpage2> createState() => _loginpage2State();
}

class _loginpage2State extends State<loginpage2> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  GlobalKey<FormState> keyForm= GlobalKey<FormState>();

  bool isLoading = false;
  Future<loginpage2?> loginAccount() async{
    //handle error
    try{
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.post(Uri.parse('http://192.168.43.109/edukasi/login.php'),
          body: {
            "username": txtUsername.text,
            "password": txtPassword.text,
          }
      );
      Login2 data = login2FromJson(response.body);
      //cek kondisi
      if(data.value == 1){
        //kondisi ketika berhasil
        setState(() {
          isLoading = false;
          session.saveSession(data.value ?? 0, data.id ?? "", data.username ?? "");
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );

          //pindah ke page login
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
          => PageBerita()
          ), (route) => false);
        });
      }else if(data.value == 0){
        //kondisi akun sudah ada
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );
        });
      }else{
        //gagal
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );
        });
      }

    }catch (e){
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString()))
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Form  Login'),
      ),

      body: Form(
        key: keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  //validasi kosong
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtUsername,
                  decoration: InputDecoration(
                      hintText: 'Input Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 8,),


                SizedBox(height: 8,),
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtPassword,
                  obscureText: true,//biar password nya gak keliatan
                  decoration: InputDecoration(
                      hintText: 'Input Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),

                SizedBox(height: 15,),
                Center( child: isLoading ? Center(
                  child: CircularProgressIndicator(),
                ) : MaterialButton(onPressed: (){

                  //cek validasi form ada kosong atau tidak
                  if(keyForm.currentState?.validate() == true){
                    setState(() {
                      loginAccount();
                    });
                  }

                },
                  child: Text('Login'),
                  color: Colors.green,
                  textColor: Colors.white,
                )
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 1, color: Colors.green)
          ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)
            => register2()
            ));
          },
          child: Text('Anda belum punya account? Silkan Register'),
        ),
      ),
    );
  }
}
