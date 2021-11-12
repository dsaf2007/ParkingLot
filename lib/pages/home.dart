// home.dart
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    int screenIndex = 0;
    // bottom nav bar
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: '즐겨찾기'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_outlined), label: '예약내역'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '마이페이지')
        ],
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.grey,

        onTap: (value) {
          setState(() {
            screenIndex = value;
          });
        },
      ),
      body: Center(
        child: Text("HomePage")
      ),
    );
  }
}
