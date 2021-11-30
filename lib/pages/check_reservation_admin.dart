import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/widget/filtering.dart';
import 'package:parkinglot/widget/navigation_bar.dart';
import 'package:parkinglot/widget/user_data_table.dart';

class CheckReservationAdmin extends StatefulWidget {
  @override
  _CheckReservationAdminState createState() => _CheckReservationAdminState();
}

class _CheckReservationAdminState extends State<CheckReservationAdmin> {
  String selectedLocationFirst = '';
  String selectedLocationSecond = '';

  Map<String, List<String>> locationList = {
    '시/도': ['시/군/구'],
  };
  List<String> cities = [];

  final Stream<QuerySnapshot> locations = FirebaseFirestore.instance
      .collection('Location')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    bool isAdmin = true;
    return StreamBuilder<QuerySnapshot>(
      stream: locations,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          selectedLocationFirst = '';
          selectedLocationSecond = '';
          return Text("Loading");
        }
        String temp = '강원도';
        for (var doc in snapshot.data!.docs) {
          //ParkingLotItem(this.image_path, this.name, this.address, this.telephone,
          // this.minute, this.fee, this.total_space, this.favorite)
          if (doc["state"] != temp) {
            temp = doc["state"].toString();
            cities = [];
          }
          cities += [doc["city"].toString()];
          locationList[doc["state"].toString()] = cities;
        }
        if (selectedLocationFirst == '') {
          selectedLocationFirst = locationList.keys.toList()[1];
        } else {
          print("selected : " + selectedLocationFirst);
        }
        selectedLocationSecond =
            locationList[selectedLocationFirst]!.first.toString();

        return Scaffold(
          appBar: AppBar(
            // 값 전달 받기
            title: const Text('전체 예약내역 확인',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text('지역선택',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Row(children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: DropdownButton<String>(
                          value: selectedLocationFirst,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLocationFirst = newValue!;
                            });
                            setState(() {});
                          },
                          items: locationList.keys
                              .toList()
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: DropdownButton<String>(
                          value: selectedLocationSecond,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedLocationSecond = newValue!;
                            });
                          },
                          items: locationList[selectedLocationFirst]!
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )),
                  ]),
                  FilteringWidget(context),
                ],
              ),
              UserDataTableWidget(context)
            ],
          ),
          bottomNavigationBar:
              NaviBarButtons(MediaQuery.of(context).size, context),
        );
      },
    );
  }
}
