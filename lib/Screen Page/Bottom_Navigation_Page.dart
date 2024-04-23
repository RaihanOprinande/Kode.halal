import 'package:demouas/Screen%20Page/Gambar_Page.dart';
import 'package:demouas/Screen%20Page/List_Edukasi_Page.dart';
import 'package:demouas/Screen%20Page/Page_user.dart';
import 'package:demouas/Screen%20Page/Register_Page.dart';
import 'package:flutter/material.dart';

import 'Page_Pegawai.dart';


class PageBottomNavigationBar extends StatefulWidget {
  const PageBottomNavigationBar({super.key});

  @override
  State<PageBottomNavigationBar> createState() =>
      _PageBottomNavigationBarState();
}

class _PageBottomNavigationBarState extends State<PageBottomNavigationBar>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: const [PageListEdukasi(), PageUser(), ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            controller: tabController,
            tabAlignment: TabAlignment.center,
            tabs: const [
              Tab(
                text: "Berita",
                icon: Icon(Icons.input),
              ),
              Tab(
                text: "User",
                icon: Icon(Icons.grid_3x3),
              ),
            ],
          ),


      ),
    );
  }
}
