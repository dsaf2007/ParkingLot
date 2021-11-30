import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';

class ReservationItem {
  ParkingLotItem parkingLotItem;
  String date;
  String total_fee;
  String start_time;
  String end_time;

  ReservationItem(this.parkingLotItem, this.date, this.total_fee,
      this.start_time, this.end_time);
}
