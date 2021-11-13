import 'package:flutter/material.dart';
import 'package:parkinglot/widget/navigationBar.dart';

class Reservations extends StatefulWidget {
  const Reservations({Key? key}) : super(key: key);

  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:
            NaviBarButtons(MediaQuery.of(context).size, context),
        body: Text("Reservation List"));
  }
}
