// home.dart
import 'package:flutter/material.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/pages/reservations.dart';
import 'package:parkinglot/pages/search.dart';
import 'package:parkinglot/pages/mypage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bottom nav bar
    return Scaffold(
      body: TabBarView(
        children: <Widget>[
          HomePage(),
          SearchPage(title: "Search"),
          Favorites(),
          Reservations(),
          MyPage(),
        ],
        controller: _controller,
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(icon: Icon(Icons.home_outlined), text: '홈'),
          Tab(icon: Icon(Icons.search), text: '검색'),
          Tab(icon: Icon(Icons.favorite_border), text: '즐겨찾기'),
          Tab(icon: Icon(Icons.receipt_outlined), text: '예약내역'),
          Tab(icon: Icon(Icons.person_outline), text: '마이페이지'),
        ],
        controller: _controller,
        labelColor: blue,
        unselectedLabelColor: lightGrey,

        // selectedLabelColor: Colors.grey,
        // unselectedItemColor: Colors.grey,
        // backgroundColor: Colors.grey,
        onTap: (value) {
          setState(() {});
        },
      ),
    );
  }
}
