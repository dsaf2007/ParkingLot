import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkinglot/pages/favorites.dart';
import '../widget/navigation_bar.dart';

// import 'package:parkinglot/models/parking_lot.dart' as globals;

import '../util/colors.dart';
import 'datetime_selection.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  _SearchPageState();
  List<ParkingLotItem> parkingLotItemList = [];
  List<DocumentSnapshot> products = [];
  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 10;
  late DocumentSnapshot lastDocument;
  final ScrollController _scrollController = ScrollController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  getParkinglots() async {
    if (!hasMore) {
      print('No More Parkinglot');
      return;
    }
    if (isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot;
    // if (lastDocument == null) {
    //   querySnapshot =
    //       await firestore.collection('ParkingLot').limit(documentLimit).get();
    // } else {
    parkingLotItemList.clear();
    querySnapshot = await firestore
        .collection('ParkingLot')
        .orderBy('code')
        .limit(documentLimit)
        .get();
    print(1);
    //}
    if (querySnapshot.docs.length < documentLimit) {
      hasMore = false;
    }
    products.addAll(querySnapshot.docs);
    for (var doc in querySnapshot.docs) {
      parkingLotItemList.add(ParkingLotItem(
          doc["name"],
          doc["address"],
          doc["telephone"],
          doc["parkingtime_permin"],
          doc["pay_fee"],
          doc["capacity"],
          false));
      print("doc :" + doc["name"]);
      lastDocument = doc;
    }
    documentLimit += 10;
    setState(() {
      isLoading = false;
      lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      lastDocument = products.last;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        getParkinglots();
        print(
            "scrollingscrollingscrollingscrollingscrollingscrollingscrollingscrollingscrollingscrolling");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //bool isAdmin = true;
    //comment for comit test
    bool isAdmin = true;
    CollectionReference parkinglots =
        FirebaseFirestore.instance.collection('ParkingLot');

    String testUserName = 'leejaewon'; //테스트용 이름
    return FutureBuilder<QuerySnapshot>(
      future: parkinglots.orderBy('code').limit(documentLimit).get(),
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
            lastDocument = doc;
          }
          // getParkinglots();
          // lastDocument = snapshot.docs[snapshot.docs.length - 1];
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
                itemCount: parkingLotItemList.length,
                controller: _scrollController,
                //itemCount: products.length,
                itemBuilder: (context, index) {
                  //getParkinglots();
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
                                      Text(parkingLotItemList[index]
                                              .telephone
                                              .isEmpty
                                          ? "전화번호 없음"
                                          : parkingLotItemList[index]
                                              .telephone),
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
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("Favorites")
                                          .doc(parkingLotItemList[index].name +
                                              '_' +
                                              testUserName)
                                          .set({
                                        "user_name": testUserName,
                                        "name": parkingLotItemList[index].name,
                                        "address":
                                            parkingLotItemList[index].address,
                                        "telephone":
                                            parkingLotItemList[index].telephone,
                                        "minute":
                                            parkingLotItemList[index].minute,
                                        "fee": parkingLotItemList[index].fee,
                                        "total_space": parkingLotItemList[index]
                                            .total_space,
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FavoritesPage()));
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
