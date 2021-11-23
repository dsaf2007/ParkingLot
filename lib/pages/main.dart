import 'package:flutter/material.dart';
import 'home.dart';
import 'datetime_selection.dart';
import 'manage_parkinglot.dart';

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
      // home: DateTimeSelection());
      home: ManageParkingLot(),
    );
  }
}
