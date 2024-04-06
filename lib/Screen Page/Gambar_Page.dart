import 'package:flutter/material.dart';

import 'Detail_Gambar_Page.dart';
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

    },
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
          gridDelegate: const
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            DetailGrid(listGambar[index])));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridTile(
                    footer: Container(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color:
                          Colors.black)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [


                        ],
                      ),
                    ),
                    child:
                    Image.asset("gambar/${listGambar[index]["gambar"]}")),
              ),
            );
          }),
    );
  }
}