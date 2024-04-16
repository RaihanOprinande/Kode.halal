import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Detail_gambar.dart';

class PageGambar extends StatefulWidget {
  const PageGambar({super.key});

  @override
  State<PageGambar> createState() => _CustomeGridState();
}

class _CustomeGridState extends State<PageGambar> {
  List<Map<String, dynamic>> listGambar = [
    {
      "gambar": "aurora.jpeg",
    },
    {
      "gambar": "bromo.jpeg",
    },
    {
      "gambar": "grandcanyon.jpeg",
    },
    {
      "gambar": "greatbarierbreef.jpeg",
    },
    {
      "gambar": "mountheverest.jpeg",
    },
    {
      "gambar": "victoriafalls.jpeg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gambar"),
        backgroundColor: Colors.green,
      ),
      body: GridView.builder(
          itemCount: listGambar.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DetailGambar(listGambar[index])));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridTile(
                    child:
                        Image.asset("gambar/${listGambar[index]["gambar"]}")),
              ),
            );
          }),
    );
  }
}
