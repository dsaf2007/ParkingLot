import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/search.dart';
import '../pages/favorites.dart';
import '../pages/reservations.dart';
import '../pages/mypage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
