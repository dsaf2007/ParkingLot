// home.dart
import 'package:flutter/material.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/pages/reservations.dart';
import 'package:parkinglot/pages/search.dart';
import 'package:parkinglot/pages/mypage.dart';
import 'package:parkinglot/widget/navigationBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // bottom nav bar
    return Scaffold(
      body: Text("Home"),
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
    );
  }
}
