import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/util/colors.dart';
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

  List<String> parkingLotList = ['주차장', '첫번째 주차장', '두번째 주차장', '세번째 주차장'];
  String selectedParkingLot = '주차장';

  @override
  Widget build(BuildContext context) {
    bool isAdmin = true;
    CollectionReference locations =
        FirebaseFirestore.instance.collection('Location');
    return FutureBuilder<QuerySnapshot>(
        future: locations.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Sth Wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            // Map<String, dynamic> data =
            //     snapshot.data!.data() as Map<String, dynamic>;
            // this.userName = data['Name'];
            // this.userPhoneNumber = data['User_PhoneNum'];
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
            selectedLocationFirst = locationList.keys.toList()[1];
            selectedLocationSecond =
                locationList[selectedLocationFirst]!.first.toString();

            return Scaffold(
              appBar: AppBar(
                  // 값 전달 받기
                  title: const Text('예약내역 확인',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  leading: GestureDetector(
                      onTap: () {}, child: const Icon(Icons.arrow_back))),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                        child: Text('지역선택',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(140, 15, 0, 0),
                        child: Text('주차장 선택',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
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
                          padding: EdgeInsets.all(0),
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
                            items: locationList["서울특별시"]!
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: DropdownButton<String>(
                            value: selectedParkingLot,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedParkingLot = newValue!;
                              });
                            },
                            items: parkingLotList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                  UserDataTableWidget(context)
                ],
              ),
              bottomNavigationBar:
                  NaviBarButtons(MediaQuery.of(context).size, context),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
