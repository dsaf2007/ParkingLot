import 'package:flutter/material.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:parkinglot/widget/navigationBar.dart';

class ManageParkingLot extends StatefulWidget {
  const ManageParkingLot({Key? key}) : super(key: key);

  @override
  _ManageParkingLotState createState() => _ManageParkingLotState();
}

class _ManageParkingLotState extends State<ManageParkingLot> {
  bool isAdmin = false;
  String name = '행복주차장';
  String address = '서울특별시 중구 필동 4가 123';
  String fee = '4,000';
  String space = '180';
  String image = 'image.jpg';

  @override
  Widget build(BuildContext context) {
    const EdgeInsets textFormContentPadding = EdgeInsets.symmetric(
      vertical: 15.0,
      horizontal: 15.0,
    );
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("주차장 관리"),
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
                Tab(text: '주차장 등록'),
                Tab(text: '주차장 수정 / 삭제'),
              ],
            )),
            Container(
              height: 570, //height of TabBarView
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
                                  hintText: name,
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
                                  hintText: address,
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
                                  hintText: fee,
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
                                  hintText: space,
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
                                      hintText: image,
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
                                "수정하기",
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
                ],
              ),
            ),
          ])),
    );
  }
}
