// home.dart
import 'package:flutter/material.dart';
import 'package:parkinglot/widget/navigationBar.dart';
// google map
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
      body: Center(child: Text("HomePage")),
    );
  }
}
