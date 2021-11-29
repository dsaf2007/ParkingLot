import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';

class ReservationItem {
  ParkingLotItem parkingLotItem;
  bool is_current;
  String start_time;
  String end_time;
  String date;
  String total_fee;

  ReservationItem(this.parkingLotItem, this.date, this.start_time,
      this.end_time, this.total_fee, this.is_current);
}
