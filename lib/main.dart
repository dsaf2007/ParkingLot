import 'package:flutter/material.dart';
import 'package:parkinglot/pages/check_reservation.dart';
import 'package:parkinglot/pages/datetime_selection.dart';
import 'package:table_calendar/table_calendar.dart';
import 'pages/home.dart';
import 'pages/manage_parkinglot.dart';

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
      // home: HomePage(),
      home: ManageParkingLot(),
    );
  }
}
