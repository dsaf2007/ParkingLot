import 'package:flutter/material.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:parkinglot/widget/navigationBar.dart';

class ManageParkingLot extends StatefulWidget {
  const ManageParkingLot({Key? key}) : super(key: key);

  @override
  _ManageParkingLotState createState() => _ManageParkingLotState();
}

class _ManageParkingLotState extends State<ManageParkingLot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text("주차장 관리"),
        ),
        body: ListView(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  border: OutlineInputBorder(),
                  hintText: '이름',
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon: const Icon(Icons.map),
                  border: OutlineInputBorder(),
                  hintText: '주소',
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon: const Icon(Icons.money),
                  border: OutlineInputBorder(),
                  hintText: '주차장 요금 (30분 단위)',
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon: const Icon(Icons.car_rental),
                  border: OutlineInputBorder(),
                  hintText: '전체 주차면 수',
                )),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  icon: const Icon(Icons.picture_as_pdf),
                  border: OutlineInputBorder(),
                  hintText: '주차장 이미지',
                )),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("등록하기"),
          )
        ]));
  }
}
