import 'package:demouas/Model/Model_Register2.dart';
import 'package:demouas/Screen%20Page/Page_Login2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class register2 extends StatefulWidget {
  const register2({super.key});

  @override
  State<register2> createState() => _register2State();
}

class _register2State extends State<register2> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtFullName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtNohp = TextEditingController();

  GlobalKey<FormState> keyForm= GlobalKey<FormState>();

  //proses untuk hit api
  bool isLoading = false;
  Future<Register2?> registerAccount() async{
    //handle error
    try{
      setState(() {
        isLoading = true;
      });

      http.Response response = await http.post(Uri.parse('http://192.168.43.109/edukasi/register.php'),
          body: {
            "username": txtUsername.text,
            "password": txtPassword.text,
            "fullname": txtFullName.text,
            "email": txtEmail.text,
            "nohp": txtNohp.text,
          }
      );

      Register2 data = register2FromJson(response.body);
      //cek kondisi
      if(data.value == 1){
        //kondisi ketika berhasil register
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}'))
          );

          //pindah ke page login
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)
          => loginpage2()
          ), (route) => false);
        });
      }else if(data.value == 2){
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
        title: Text('Form  Register'),
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
                TextFormField(
                  //validasi kosong
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtFullName,
                  decoration: InputDecoration(
                      hintText: 'Input Full Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  //validasi kosong
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtEmail,
                  decoration: InputDecoration(
                      hintText: 'Input Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 8,),
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "tidak boleh kosong " : null;
                  },
                  controller: txtNohp,
                  // obscureText: true,//biar password nya gak keliatan
                  decoration: InputDecoration(
                      hintText: 'Input nohpa',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
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
                      registerAccount();
                    });
                  }

                },
                  child: Text('Register'),
                  color: Colors.green,
                  textColor: Colors.white,
                )
                )],
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
            => loginpage2()
            ));
          },
          child: Text('Anda sudah punya account? Silkan Login'),
        ),
      ),
    );
  }
}
