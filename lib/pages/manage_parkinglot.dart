import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:parkinglot/models/parkinglot_item.dart';

import 'package:parkinglot/widget/navigation_bar.dart';

class ManageParkingLot extends StatefulWidget {
  const ManageParkingLot({Key? key}) : super(key: key);

  @override
  _ManageParkingLotState createState() => _ManageParkingLotState();
}

class _ManageParkingLotState extends State<ManageParkingLot> {
  bool isAdmin = false;
  String name = '행복주차장';
  String address = '서울특별시 중구 필동 4가 123';
  String cost = '4,000';
  String totalSpace = '180';
  String imagePath = 'image.jpg';

  EdgeInsets textFormContentPadding = EdgeInsets.symmetric(
    vertical: 15.0,
    horizontal: 15.0,
  );
  List<ParkingLotItem> parkingLotItemList = [];

  final Stream<QuerySnapshot> parkinglots = FirebaseFirestore.instance
      .collection('ParkingLot')
      .orderBy('code')
      .snapshots(includeMetadataChanges: true);

  void showAlert(BuildContext context, String _cost) {
    TextButton cancelButton = TextButton(
      child: Text("취소"),
      onPressed: () {
        //Put your code here which you want to execute on Yes button click.
        Navigator.of(context).pop();
      },
    );
    TextButton acceptButton = TextButton(
      child: Text("확인"),
      onPressed: () {
        //Put your code here which you want to execute on Cancel button click.
        Navigator.of(context).pop();
      },
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "새로운 요금 입력 (30분 당 이용요금)",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: _cost,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                cancelButton,
                acceptButton,
              ],
            )
          ],
        ),
        // actions: [
        //   cancelButton,
        //   acceptButton,
        // ],
      ),
    );
  }

  CollectionReference update =
      FirebaseFirestore.instance.collection('ParkingLot');

  Future<void> updateFee(int code, int fee) async {
    var doc_id = '';
    var doc_parse = [];
    print("update2 " + code.toString());
    FirebaseFirestore.instance
        .collection('ParkingLot')
        .where('code', isEqualTo: code)
        .get()
        .then((QuerySnapshot snapshot) {
      print("doc doc");
      for (var doc in snapshot.docs) {
        doc_id = doc.reference.path.toString();
        doc_parse = doc_id.split("/");
        print("abc" + doc_parse[1]);
        return update
            .doc(doc_parse[1])
            .update({'pay_fee': fee})
            .then((value) => print("Fee Updated"))
            .catchError((error) => print("Failed to update fee: $error"));
      }
    });
    print(doc_id + " dkdkdkdkdkdkdkdkdk");
  }

  Future<void> deleteParkingLot(int code) async {
    var doc_id = '';
    var doc_parse = [];
    print("update2 " + code.toString());
    FirebaseFirestore.instance
        .collection('ParkingLot')
        .where('code', isEqualTo: code)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        doc_id = doc.reference.path.toString();
        doc_parse = doc_id.split("/");
        print("abc" + doc_parse[1]);
        return update
            .doc(doc_parse[1])
            .delete()
            .then((value) => print("ParkingLot Deleted"))
            .catchError(
                (error) => print("Failed to delete ParkingLot: $error"));
      }
    });
    print(doc_id + " dkdkdkdkdkdkdkdkdk");
  }

  Future<void> addParkingLot(
      String name, String address, int fee, int capacity) {
    // Call the user's CollectionReference to add a new user
    return FirebaseFirestore.instance
        .collection('ParkingLot')
        .add({
          'name': name,
          'address': address,
          'pay_fee': fee,
          'capacity': capacity
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    bool isAdmin = true;
    String testUserName = 'leejaewon'; //테스트용 이름

    return StreamBuilder<QuerySnapshot>(
        stream: parkinglots,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Sth Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
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
                false));
          }
          print(parkingLotItemList.first.name);
          return Scaffold(
            appBar: AppBar(
              // 값 전달 받기
              title: Text('주차장 관리',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              centerTitle: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            body: DefaultTabController(
                length: 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          child: TabBar(
                        indicatorColor: Colors.black54,
                        indicatorWeight: 4,
                        //밑줄 길이
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black54,
                        tabs: [
                          Tab(
                            child: Text("주차장 등록",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Tab(
                            child: Text("주차장 수정/삭제",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      )),
                      Container(
                        height: 500, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: TabBarView(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 40, 10, 0),
                                child: ListView(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 10, 15, 10),
                                      child: TextFormField(
                                          autofocus: true,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                textFormContentPadding,
                                            icon: const Icon(Icons.person),
                                            border: OutlineInputBorder(),
                                            hintText: '이름',
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 10, 15, 10),
                                      child: TextFormField(
                                          autofocus: true,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                textFormContentPadding,
                                            icon: const Icon(Icons.location_on),
                                            border: OutlineInputBorder(),
                                            hintText: '주소',
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 10, 15, 10),
                                      child: TextFormField(
                                          autofocus: true,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                textFormContentPadding,
                                            icon:
                                                const Icon(Icons.attach_money),
                                            border: OutlineInputBorder(),
                                            hintText: '주차장 요금 (30분 단위)',
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 10, 15, 10),
                                      child: TextFormField(
                                          autofocus: true,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                textFormContentPadding,
                                            icon: const Icon(
                                                Icons.directions_car),
                                            border: OutlineInputBorder(),
                                            hintText: '전체 주차면 수',
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(15, 10, 15, 10),
                                      child: ElevatedButton(
                                        style: ButtonStyle(),
                                        onPressed: () {
                                          addParkingLot(
                                              name, address, fee, capacity);
                                        },
                                        child: Text(
                                          "등록하기",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: ListView.builder(
                                    itemCount: parkingLotItemList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1.0, horizontal: 1.0),
                                        child: Card(
                                          child: ListTile(
                                            onTap: () {},
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                          parkingLotItemList[index]
                                                                              .name,
                                                                          style: TextStyle(
                                                                              fontSize: 23,
                                                                              color: Colors.black87,
                                                                              fontWeight: FontWeight.bold)),
                                                                      SizedBox(
                                                                          width:
                                                                              102),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon: Icon(
                                                                            Icons.close),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  Text(parkingLotItemList[
                                                                          index]
                                                                      .address),
                                                                  Text(parkingLotItemList[
                                                                          index]
                                                                      .telephone),
                                                                  Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        parkingLotItemList[index].fee.toString() +
                                                                            "원",
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(
                                                                          "(30분 기준)"),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  )
                                                                ]),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    showAlert(
                                                        context,
                                                        parkingLotItemList[
                                                                index]
                                                            .fee
                                                            .toString());
                                                    updateFee(
                                                        parkingLotItemList[
                                                                index]
                                                            .code,
                                                        10000);
                                                    setState(() {});
                                                  },
                                                  child: Text(
                                                    "요금 수정하기",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // --- 이미지 넣기 ---
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ])),
            bottomNavigationBar: NaviBarButtons(
              MediaQuery.of(context).size,
              context,
            ),
          );
        });
  }
}
