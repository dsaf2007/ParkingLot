import 'package:flutter/material.dart';

class customerData with ChangeNotifier {
  bool isAdmin = true;
  String name = 'tempName';
  String id = 'tempID';
  int password = 11111111;
  String telephone = 'tempTel';
  int car_num = 1234;

  void adminEdit(bool isAd) {
    isAdmin = isAd;
    notifyListeners();
  }

  void userNameEdit(String name) {
    this.name = name;
    notifyListeners();
  }

  void userIdEdit(String id) {
    this.id = id;
    notifyListeners();
  }

  void userPwEdit(int pw) {
    password = pw;
    notifyListeners();
  }

  void userTelEdit(String tel) {
    telephone = tel;
    notifyListeners();
  }

  void carNumEdit(int num) {
    car_num = num;
    notifyListeners();
  }
}
