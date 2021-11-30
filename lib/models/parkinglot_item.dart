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
  int code;
  bool favorite;
  int weekday_begin;
  int weekday_end;
  int weekend_begin;
  int weekend_end;

  ParkingLotItem(
      this.name,
      this.address,
      this.telephone,
      this.minute,
      this.fee,
      this.total_space,
      this.code,
      this.favorite,
      this.weekday_begin,
      this.weekday_end,
      this.weekend_begin,
      this.weekend_end);
}
