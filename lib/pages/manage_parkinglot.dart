import 'package:flutter/material.dart';
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
  String dropDownValue = "중구";
  List<String> positionList = ["중구", "강서구", "서초구", "강남구"];
  List<ParkingLotItem> parkinglotToManage = [
    ParkingLotItem('대한극장주차장1', '서울 중구 필동 2가', '02-1234-5678', 30, 800, 30, true),
    ParkingLotItem('대한극장주차장1', '서울 중구 필동 2가', '02-1234-5678', 30, 800, 30, true),
    ParkingLotItem('대한극장주차장1', '서울 중구 필동 2가', '02-1234-5678', 30, 800, 30, true),
    ParkingLotItem('대한극장주차장1', '서울 중구 필동 2가', '02-1234-5678', 30, 800, 30, true),
  ];

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

  @override
  Widget build(BuildContext context) {
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
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 0.5))),
              child: TabBarView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 10, 0),
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: textFormContentPadding,
                                  icon: const Icon(Icons.person),
                                  border: OutlineInputBorder(),
                                  hintText: '이름',
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: textFormContentPadding,
                                  icon: const Icon(Icons.location_on),
                                  border: OutlineInputBorder(),
                                  hintText: '주소',
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: textFormContentPadding,
                                  icon: const Icon(Icons.attach_money),
                                  border: OutlineInputBorder(),
                                  hintText: '주차장 요금 (30분 단위)',
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: TextFormField(
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: textFormContentPadding,
                                  icon: const Icon(Icons.directions_car),
                                  border: OutlineInputBorder(),
                                  hintText: '전체 주차면 수',
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: Stack(
                              alignment: const Alignment(0.95, 0),
                              children: <Widget>[
                                TextFormField(
                                    autofocus: true,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      contentPadding: textFormContentPadding,
                                      icon: const Icon(Icons.image),
                                      border: OutlineInputBorder(),
                                      hintText: '주차장 이미지',
                                    )),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: lightGrey,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      "첨부",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            child: ElevatedButton(
                              style: ButtonStyle(),
                              onPressed: () {},
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 50,
                              child: DropdownButton(
                                value: dropDownValue,
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                items: positionList.map((String items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropDownValue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
                          itemCount: parkinglotToManage.length,
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
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                      'lib/images/park.png',
                                                      width: 100,
                                                      height: 100),
                                                  SizedBox(width: 10),
                                                  Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                                parkinglotToManage[
                                                                        index]
                                                                    .name,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        23,
                                                                    color: Colors
                                                                        .black87,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(parkinglotToManage[
                                                                index]
                                                            .address),
                                                        Text(parkinglotToManage[
                                                                index]
                                                            .telephone),
                                                        Row(
                                                          children: <Widget>[
                                                            Text(
                                                              parkinglotToManage[
                                                                          index]
                                                                      .fee
                                                                      .toString() +
                                                                  "원",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text("(30분 기준)"),
                                                          ],
                                                        ),
                                                      ]),
                                                  SizedBox(width: 30),
                                                  // Align(
                                                  //   alignment:
                                                  //       Alignment.topRight,
                                                  //   child: Icon(Icons.close),
                                                  // ),
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(Icons.close),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          showAlert(
                                              context,
                                              parkinglotToManage[index]
                                                  .fee
                                                  .toString());
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
  }
}
