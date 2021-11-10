import 'package:flutter/material.dart';
class ParkingLot {
  String imagePath;
  String name;
  String address;
  String number;
  int cost;
  int total_space;
  bool favorite;

  ParkingLot(this.imagePath, this.name, this.address, this.number, this.cost,
      this.total_space, this.favorite);
}