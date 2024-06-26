import 'package:demouas/Model/Model_Update_Pegawai.dart';
import 'package:demouas/Screen%20Page/Add_Pegawai.dart';
import 'package:demouas/Screen%20Page/Update_Pegawai_Page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/Model_Pegawai.dart';
import '../Utils/Session_Manager.dart';
import 'Login_page.dart';

class PagePegawai extends StatefulWidget {
  const PagePegawai({super.key});

  @override
  State<PagePegawai> createState() => _PagePegawaiState();
}

class _PagePegawaiState extends State<PagePegawai> {

  String? userName;
  String? id;

  Future getDataSession() async {
    await Future.delayed(const Duration(seconds: 1), () {
      session.getSession().then((value) {
        print('data sesi .. ' + value.toString());
        userName = session.userName;
        id = session.idUser;
      });
    });
  }

  void initState() {
    super.initState();
    session.getSession();
    getDataSession();
  }

  //method untuk get berita
  Future<List<Datum>?> getBerita() async {
    try {
      http.Response response = await http
          .get(Uri.parse("http://192.168.1.3/edukasi_server/getPegawai.php"));
      return pegawaiFromJson(response.body).data;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  List<Datum>? filterDevice;
  List<Datum>? listDevice;
  TextEditingController cari = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edukasi List'),
        backgroundColor: Colors.green,
        actions: [
          TextButton(onPressed: () {}, child: Text('HI ${id}')),
          //logout
          IconButton(
            onPressed: () {
              //clear session
              setState(() {
                session.clearSession();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
              });
            },
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Logout',
          )
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: cari,
            onChanged: (value) {
              setState(() {
                filterDevice = listDevice
                    ?.where((element) =>
                element.nama!
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                    element.nobp!
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              });
            },
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 15,),
          MaterialButton(onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder:
                (_) => addpegawais()));
          },
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            color: Color(0xff333333),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)
            ),
            child: Text(
              'Tambah Pegawai',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.8),
          ),
          Expanded(
            child: FutureBuilder(
              future: getBerita(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                if (snapshot.hasData) {
                  listDevice = snapshot.data;
                  if (filterDevice == null) {
                    filterDevice = listDevice;
                  }
                  return ListView.builder(
                      itemCount: filterDevice!.length,
                      itemBuilder: (context, index) {
                        Datum? data = filterDevice?[index];
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                                //ini untuk ke detail
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => pegawaiupdate()));
                            },
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "${data?.nama}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                          fontSize: 18),
                                    ),
                                    subtitle: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${data?.nobp}",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.black),
                                        ),
                                        Text("${data?.nama}",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.black),
                                        ),
                                        Text("${data?.nohp}",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.black),
                                        ),
                                        Text("${data?.email}",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.black),
                                        ),
                                        Text("${data?.tanggalInput}",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.black),
                                        ),

                                      ]

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
