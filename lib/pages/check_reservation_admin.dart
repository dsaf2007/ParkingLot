import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/pages/mypage.dart';
import 'package:parkinglot/widget/navigation_bar.dart';

class CheckReservationAdmin extends StatefulWidget {
  @override
  _CheckReservationAdminState createState() => _CheckReservationAdminState();
}

class _CheckReservationAdminState extends State<CheckReservationAdmin> {
  String selectedLocation = '지역';
  String selectedParkingLot = '주차장 선택';

  @override
  Widget build(BuildContext context) {
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('지역선택',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(100, 20, 20, 20),
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
                  padding: EdgeInsets.fromLTRB(20, 5, 100, 5),
                  child: DropdownButton<String>(
                    value: selectedLocation,
                    icon: const Icon(Icons.arrow_downward),
                    style: const TextStyle(
                      color: darkGrey,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedLocation = newValue!;
                      });
                    },
                    items: <String>['지역', 'One', 'Two', 'Free', 'Four']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ))
            ],
          ),
        ],
      ),
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
    );
  }
}
