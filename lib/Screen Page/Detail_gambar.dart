import 'package:flutter/material.dart';

class DetailGambar extends StatelessWidget {
  final Map<String, dynamic> detailGambar;

  const DetailGambar(this.detailGambar, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "gambar/${detailGambar["gambar"]}",
                width: 400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
