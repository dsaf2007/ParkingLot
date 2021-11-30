import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:parkinglot/models/reservation_item.dart';

class ReservationData with ChangeNotifier {
  ReservationItem reserveData = ReservationItem(
      ParkingLotItem(
          "name", "address", "telephone", 0, 0, 0, 0, true, 0, 0, 0, 0),
      "date",
      "start_time",
      "end_time",
      "total_fee",
      true,
<<<<<<< HEAD
      false);
=======
      "reservation_code");
>>>>>>> 3e24f97eef8e2ac3ee2da96271bb46db70803ae3

  void reserveEdit(ReservationItem item) {
    reserveData = item;
    notifyListeners();
  }
}
