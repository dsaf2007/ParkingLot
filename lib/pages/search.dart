import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widget/navigation_bar.dart';

// import 'package:parkinglot/models/parking_lot.dart' as globals;

import '../util/colors.dart';
import 'datetime_selection.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ParkingLotItem> parkingLotItemList = [];

  @override
  Widget build(BuildContext context) {
    //bool isAdmin = true;
    //comment for comit test
    bool isAdmin = true;
    CollectionReference parkinglots =
        FirebaseFirestore.instance.collection('ParkingLot');

    return FutureBuilder<QuerySnapshot>(
      future: parkinglots.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Sth Wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // Map<String, dynamic> data =
          //     snapshot.data!.data() as Map<String, dynamic>;
          // this.userName = data['Name'];
          // this.userPhoneNumber = data['User_PhoneNum'];
          for (var doc in snapshot.data!.docs) {
            //ParkingLotItem(this.image_path, this.name, this.address, this.telephone,
            // this.minute, this.fee, this.total_space, this.favorite);
            print(doc);
            parkingLotItemList.add(ParkingLotItem(
                doc["name"],
                doc["address"],
                doc["telephone"],
                doc["parkingtime_permin"],
                doc["pay_fee"],
                doc["capacity"],
                false));
            print(doc);
          }
          // TODO: implement build
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  leadingWidth: 5,
                  title: TextFormField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        hintText: '  주차장 검색',
                        hintStyle: TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                        ),
                      ))),
              body: ListView.builder(
                //itemCount: parkinglot.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 3.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {},
                          subtitle: Column(children: [
                            Row(
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(parkingLotItemList[index].name,
                                          style: TextStyle(
                                              fontSize: 23,
                                              color: blue,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 5),
                                      Text(parkingLotItemList[index].address),
                                      Text(parkingLotItemList[index].telephone),
                                      Text(
                                          '30분 ${parkingLotItemList[index].fee} 원   |   총 ${parkingLotItemList[index].total_space} 면'),
                                    ]),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                        backgroundColor: lightGrey,
                                        minimumSize: Size(165, 20)),
                                    child: const Text('즐겨찾기 추가',
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                  SizedBox(width: 10),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DateTimeSelection(
                                                      parkingLotItem:
                                                          parkingLotItemList[
                                                              index])));
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: blue,
                                        minimumSize: Size(165, 20)),
                                    child: const Text('예약하기',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  SizedBox(height: 5),
                                ])
                          ]),
                          // --- 이미지 넣기 ---
                        ),
                      ));
                },
              ),
              bottomNavigationBar:
                  NaviBarButtons(MediaQuery.of(context).size, context),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
