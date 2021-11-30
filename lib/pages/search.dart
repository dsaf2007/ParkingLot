import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkinglot/main.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widget/navigation_bar.dart';
import 'package:parkinglot/providers/parkinglotdata.dart';
import 'package:parkinglot/providers/userdata.dart';
import 'package:provider/provider.dart';

// import 'package:parkinglot/models/parking_lot.dart' as globals;

import '../util/colors.dart';
import 'datetime_selection.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ParkingLotItem> parkingLotItemList = [];
  final Stream<QuerySnapshot> parkinglots = FirebaseFirestore.instance
      .collection('ParkingLot')
      .orderBy('code')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    // bool isAdmin = true;
    // String testUserName = 'leejaewon'; //테스트용 이름
    bool isAdmin = Provider.of<userData>(context, listen: false).isAdmin;
    String userName = Provider.of<userData>(context, listen: false).name;

    return StreamBuilder<QuerySnapshot>(
      stream: parkinglots,
      // Provider 이용하기 위해 BuildContext state로 수정
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Sth Wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
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
              doc["code"],
              false,
              doc["weekday_begin_time"],
              doc["weekday_end_time"],
              doc["weekend_begin_time"],
              doc["weekend_end_time"]));
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //Favorites Add-------------------------
                                TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Favorites")
                                        .doc(parkingLotItemList[index].name +
                                            '_' +
                                            userName)
                                        .set({
                                      "UserName": userName,
                                      "name": parkingLotItemList[index].name,
                                      "address":
                                          parkingLotItemList[index].address,
                                      "telephone":
                                          parkingLotItemList[index].telephone,
                                      "minute":
                                          parkingLotItemList[index].minute,
                                      "fee": parkingLotItemList[index].fee,
                                      "total_space":
                                          parkingLotItemList[index].total_space,
                                    });
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor: lightGrey,
                                      minimumSize: Size(165, 20)),
                                  child: const Text('즐겨찾기 추가',
                                      style: TextStyle(color: Colors.black)),
                                ),
                                SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    // ParkingLot Provider의 lotData 수정. 예약 확정 시 사용------------------
                                    Provider.of<parkingLotData>(context,
                                            listen: false)
                                        .lotEdit(parkingLotItemList[index]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DateTimeSelection()));
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

        return CircularProgressIndicator();
      },
    );
  }
}
