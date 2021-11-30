import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';

class ReservationItem {
  ParkingLotItem parkingLotItem;
  String date;
  String hours;
  String total_fee;

  ReservationItem(this.parkingLotItem, this.date, this.hours, this.total_fee);
}
