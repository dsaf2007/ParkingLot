import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/providers/userdata.dart';
import 'package:parkinglot/widget/navigation_bar.dart';
import 'package:provider/provider.dart';

// import 'package:parkinglot/models/parking_lot.dart' as globals;

import '../util/colors.dart';
import 'datetime_selection.dart';

import 'package:parkinglot/util/helper.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  _SearchPageState();
  List<ParkingLotItem> parkingLotItemList = [];

  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<ParkingLotItem> _filterList = [];

  bool _IsSearching = false;
  String _searchText = "";
  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  final Stream<QuerySnapshot> parkinglots = FirebaseFirestore.instance
      .collection('ParkingLot')
      .orderBy('code')
      .snapshots(includeMetadataChanges: true);

  @override
  Widget build(BuildContext context) {
    //bool isAdmin = true;
    //comment for comit test
    bool isAdmin = true;
    String testUserName = 'leejaewon'; //테스트용 이름

    return StreamBuilder<QuerySnapshot>(
      stream: parkinglots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        int tempMin = 50;
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
              true,
              doc["weekday_begin_time"],
              doc["weekday_end_time"],
              doc["weekend_begin_time"],
              doc["weekend_end_time"]));
        }
        print(parkingLotItemList.first.name);
        // TODO: implement build

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: TextField(
                  onChanged: (text) {
                    print("on changed : " + text);
                    _searchText = text;
                    _IsSearching = true;
                  },
                  controller: _searchQuery,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search, color: Colors.black),
                      hintText: "  주차장 검색 ",
                      hintStyle: TextStyle(color: mediumGrey)),
                )),
            // body: ListView(
            //   padding: EdgeInsets.symmetric(vertical: 8.0),
            //   children: <Widget>[
            //     _IsSearching ? _createListView() : _createFilteredListView()
            //   ],
            // ),
            body: Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: _IsSearching
                    ? _createFilteredListView()
                    : _createListView()),
            bottomNavigationBar:
                NaviBarButtons(MediaQuery.of(context).size, context),
          ),
        );
      },
    );
  }

  Widget _createListView() {
    return Flexible(
      child: ListView.builder(
        itemCount: parkingLotItemList.length,
        //itemCount: products.length,
        itemBuilder: (context, index) {
          bool isAdmin = Provider.of<userData>(context, listen: false).isAdmin;
          String userName = Provider.of<userData>(context, listen: false).name;
          final size = MediaQuery.of(context).size;
          Size doubleButtonSize = Size(size.width * 0.4, 20);
          //getParkinglots();
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
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
                                  style: parkingLotNameStyle),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: darkGrey,
                                    size: 13,
                                  ),
                                  SizedBox(width: 5),
                                  Text(parkingLotItemList[index].address),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: darkGrey,
                                    size: 13,
                                  ),
                                  SizedBox(width: 5),
                                  Text(parkingLotItemList[index]
                                          .telephone
                                          .isEmpty
                                      ? "전화번호 없음"
                                      : parkingLotItemList[index].telephone),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    color: darkGrey,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                      '30분 ${parkingLotItemList[index].fee} 원   |   총 ${parkingLotItemList[index].total_space} 면'),
                                ],
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("Favorites")
                                .doc(parkingLotItemList[index].name +
                                    '_' +
                                    userName) //------------------------------------------------------------------------------
                                .set({
                              "user_name": userName,
                              "name": parkingLotItemList[index].name,
                              "address": parkingLotItemList[index].address,
                              "telephone": parkingLotItemList[index].telephone,
                              "minute": parkingLotItemList[index].minute,
                              "fee": parkingLotItemList[index].fee,
                              "total_space":
                                  parkingLotItemList[index].total_space,
                              "code": parkingLotItemList[index].code,
                              "weekday_begin":
                                  parkingLotItemList[index].weekday_begin,
                              "weekday_end":
                                  parkingLotItemList[index].weekday_end,
                              "weekend_begin":
                                  parkingLotItemList[index].weekend_begin,
                              "weekend_end":
                                  parkingLotItemList[index].weekend_end,
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavoritesPage()));
                          },
                          style: buildDoubleButtonStyle(
                              lightGrey, doubleButtonSize),
                          child: const Text('즐겨찾기 추가',
                              style: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DateTimeSelection()));
                          },
                          style: buildDoubleButtonStyle(blue, doubleButtonSize),
                          child: const Text('예약하기',
                              style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(height: 5),
                      ],
                    )
                  ]),
                  // --- 이미지 넣기 ---
                ),
              ));
        },
      ),
    );
  }

  Widget _createFilteredListView() {
    print('_createFilteredListView');

    _filterList = [];
    for (int i = 0; i < parkingLotItemList.length; i++) {
      var item = parkingLotItemList[i];

      if (item.name.contains(_searchText)) {
        _filterList.add(item);
      }
    }
    return Flexible(
      child: ListView.builder(
        itemCount: _filterList.length,
        //itemCount: products.length,
        itemBuilder: (context, index) {
          bool isAdmin = Provider.of<userData>(context, listen: false).isAdmin;
          String userName = Provider.of<userData>(context, listen: false).name;
          final size = MediaQuery.of(context).size;
          Size doubleButtonSize = Size(size.width * 0.4, 20);
          //getParkinglots();
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 3.0),
              child: Card(
                child: ListTile(
                  onTap: () {},
                  subtitle: Column(children: [
                    Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_filterList[index].name,
                                  style: parkingLotNameStyle),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: darkGrey,
                                    size: 13,
                                  ),
                                  SizedBox(width: 5),
                                  Text(_filterList[index].address),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: darkGrey,
                                    size: 13,
                                  ),
                                  SizedBox(width: 5),
                                  Text(_filterList[index].telephone.isEmpty
                                      ? "전화번호 없음"
                                      : _filterList[index].telephone),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.attach_money,
                                    color: darkGrey,
                                    size: 15,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                      '30분 ${_filterList[index].fee} 원   |   총 ${_filterList[index].total_space} 면'),
                                ],
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("Favorites")
                                .doc(_filterList[index].name +
                                    '_' +
                                    userName) //------------------------------------------------------------------------------
                                .set({
                              "user_name": userName,
                              "name": _filterList[index].name,
                              "address": _filterList[index].address,
                              "telephone": _filterList[index].telephone,
                              "minute": _filterList[index].minute,
                              "fee": _filterList[index].fee,
                              "total_space": _filterList[index].total_space,
                              "code": _filterList[index].code,
                              "weekday_begin": _filterList[index].weekday_begin,
                              "weekday_end": _filterList[index].weekday_end,
                              "weekend_begin": _filterList[index].weekend_begin,
                              "weekend_end": _filterList[index].weekend_end,
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavoritesPage()));
                          },
                          style: buildDoubleButtonStyle(
                              lightGrey, doubleButtonSize),
                          child: const Text('즐겨찾기 추가',
                              style: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DateTimeSelection()));
                          },
                          style: buildDoubleButtonStyle(blue, doubleButtonSize),
                          child: const Text('예약하기',
                              style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(height: 5),
                      ],
                    )
                  ]),
                  // --- 이미지 넣기 ---
                ),
              ));
        },
      ),
    );
  }
}
