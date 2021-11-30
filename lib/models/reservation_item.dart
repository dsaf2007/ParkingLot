import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';

class ReservationItem {
  ParkingLotItem parkingLotItem;
  bool is_current;
  String date;
  String total_fee;
  String start_time;
  String end_time;
  String reservation_code;
  bool is_parked;

  ReservationItem(
      this.parkingLotItem,
      this.date,
      this.start_time,
      this.end_time,
      this.total_fee,
      this.is_current,
      this.reservation_code,
      this.is_parked);
}
