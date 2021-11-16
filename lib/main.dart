import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'pages/home.dart';
import 'pages/search.dart';
import 'pages/favorites.dart';
import 'pages/reservations.dart';
import 'pages/mypage.dart';
import 'pages/signin.dart';
import 'pages/datetime_selection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: HomePage()
        home: DateTimeSelection());
  }
}
