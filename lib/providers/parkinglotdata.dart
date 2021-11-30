import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';

class parkingLotData with ChangeNotifier {
  ParkingLotItem lotData =
      ParkingLotItem('name', 'address', 'telephone', 60, 50, 40, 123, true);

  void lotEdit(ParkingLotItem item) {
    lotData = item;
    notifyListeners();
  }

  void lotEditName(String name) {
    lotData.name = name;
    notifyListeners();
  }

  void lotEditAddress(String address) {
    lotData.address = address;
    notifyListeners();
  }

  void lotEditTel(String tel) {
    lotData.telephone = tel;
    notifyListeners();
  }

  void lotEditMin(int min) {
    lotData.minute = min;
    notifyListeners();
  }

  void lotEditFee(int fee) {
    lotData.fee = fee;
    notifyListeners();
  }

  void lotEditSpace(int space) {
    lotData.total_space = space;
    notifyListeners();
  }

  void lotEditFav(bool fav) {
    lotData.favorite = fav;
    notifyListeners();
  }
}
