import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';

class parkingLotData with ChangeNotifier {
  ParkingLotItem lotData = ParkingLotItem(
      'name', 'address', 'telephone', 60, 50, 40, 123, true, 0, 0, 0, 0);

  void lotEdit(ParkingLotItem item) {
    lotData = item;
    notifyListeners();
  }

// parkinglot data는 ParkingLotItem 객체로 받아오기 때문에 아래 func는 필요치 않을 예정;
  // void lotEditName(String name) {
  //   lotData.name = name;
  //   notifyListeners();
  // }

  // void lotEditAddress(String address) {
  //   lotData.address = address;
  //   notifyListeners();
  // }

  // void lotEditTel(String tel) {
  //   lotData.telephone = tel;
  //   notifyListeners();
  // }

  // void lotEditMin(int min) {
  //   lotData.minute = min;
  //   notifyListeners();
  // }

  // void lotEditFee(int fee) {
  //   lotData.fee = fee;
  //   notifyListeners();
  // }

  // void lotEditSpace(int space) {
  //   lotData.total_space = space;
  //   notifyListeners();
  // }

  // void lotEditFav(bool fav) {
  //   lotData.favorite = fav;
  //   notifyListeners();
  // }
}
