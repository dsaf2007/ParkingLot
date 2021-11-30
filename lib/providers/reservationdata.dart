import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:parkinglot/models/reservation_item.dart';
import 'package:parkinglot/providers/parkinglotdata.dart';
import 'package:provider/provider.dart';

class ReservationData with ChangeNotifier {
  ReservationItem reserveData = ReservationItem(
      ParkingLotItem(
          "name", "address", "telephone", 0, 0, 0, 0, true, 0, 0, 0, 0),
      "date",
      "start_time",
      "end_time",
      "total_fee",
      true);

  void reserveEdit(ReservationItem item) {
    reserveData = item;
    notifyListeners();
  }
}
