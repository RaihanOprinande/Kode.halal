import 'dart:ui';

import 'package:demouas/Model/Model_Edukasi.dart';
import 'package:demouas/Screen%20Page/Detail_Edukasi_Page.dart';
import 'package:demouas/Screen%20Page/Login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Utils/Session_Manager.dart';

class PageListEdukasi extends StatefulWidget {
  const PageListEdukasi({super.key});



  @override
  State<PageListEdukasi> createState() => _PageListEdukasiState();
}



class _PageListEdukasiState extends State<PageListEdukasi> {
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
          .get(Uri.parse("http://192.168.43.109/edukasi_server/getBerita.php"));
      return edukasiFromJson(response.body).data;
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
          TextButton(onPressed: () {}, child: Text('HI ${userName}')),
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
                element.judul!
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                    element.berita!
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
                              //   //ini untuk ke detail
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DetailEdukasi(data)));
                            },
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'http://192.168.43.109/edukasi_server/gambar_berita/${data?.gambar}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      "${data?.judul}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                          fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      "${data?.berita}",
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black),
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
