import 'package:flutter/material.dart';
// import 'package:parkinglot/pages/search.dart' as globals;


// 이름, 주소, 전화번호, 분, 금액, 총 면수
class ParkingLotItem {
  String name;
  String address;
  String telephone;
  int minute;
  int fee;
  int total_space;
  bool favorite;

  ParkingLotItem(this.name, this.address, this.telephone, 
    this.minute, this.fee, this.total_space, this.favorite);
}