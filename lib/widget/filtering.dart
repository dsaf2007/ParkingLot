import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:parkinglot/pages/check_reservation.dart';
import '../util/colors.dart';

Widget FilteringWidget(BuildContext context) {
  final Stream<QuerySnapshot> parkinglots = FirebaseFirestore.instance
      .collection('ParkingLot')
      .limit(15) // 개수 제한
      .snapshots(includeMetadataChanges: true);

  String selectedParkingLot = '';

  List<ParkingLotItem> parkingLotItemList = [];
  List<String> parkingLotItemNameList = [
    '주차장',
  ];

  return StreamBuilder<QuerySnapshot>(
      stream: parkinglots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Sth Wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          selectedParkingLot = '';
        }

        if (selectedParkingLot == '') {
          selectedParkingLot = parkingLotItemNameList.first.toString();
        }
        for (var doc in snapshot.data!.docs) {
          parkingLotItemList.add(ParkingLotItem(
              doc["name"],
              doc["address"],
              doc["telephone"],
              doc["parkingtime_permin"],
              doc["pay_fee"],
              doc["capacity"],
              doc["code"],
              true,
              doc["weekday_begin_time"],
              doc["weekday_end_time"],
              doc["weekend_begin_time"],
              doc["weekend_end_time"]));
          parkingLotItemNameList.add(doc["name"]);
        }
        print(parkingLotItemNameList);
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Text('주차장 선택',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                  child: DropdownButton<String>(
                    value: selectedParkingLot,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    items: parkingLotItemNameList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ))
            ]);
      });
}
