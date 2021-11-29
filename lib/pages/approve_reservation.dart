import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/pages/mypage.dart';
import 'package:parkinglot/widget/navigation_bar.dart';

import 'check_reservation.dart';
import '../models/parkinglot_item.dart';
import '../models/reservation_item.dart';

class ApproveReservation extends StatefulWidget {
  final ReservationItem reservationItem;
  const ApproveReservation({Key? key, required this.reservationItem})
      : super(key: key);
  @override
  _ApproveReservationState createState() => _ApproveReservationState();
}

class _ApproveReservationState extends State<ApproveReservation> {
  String reserveDate = '2021.11.19 (금)';
  String reserveStartTime = '09:00';
  String reserveEndTime = '10:00';

  String parkingLotName = '대한극장';
  String parkingLotAddress = '서울 중구 필동 2가';
  String parkingLotTime_week = '00:00~24:00';
  String parkingLotTime_sat = '00:00~24:00';
  String parkingLotTime_sun = '00:00~24:00';

  String parkingLotNumber = '02-1234-1234';
  int parkingLotFee = 800;
  int total = 1600;

  @override
  Widget build(BuildContext context) {
    ParkingLotItem parkingLotItem = widget.reservationItem.parkingLotItem;
    return Scaffold(
      appBar: AppBar(
          // 값 전달 받기
          title: Text(parkingLotItem.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          leading: GestureDetector(
              onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      content: Text(
                        '선택하신 내용들이 초기화됩니다. 뒤로 가시겠습니까?',
                        style: TextStyle(fontSize: 15),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: blue,
                              minimumSize: Size(130, 20)),
                          child: const Text('예',
                              style: TextStyle(color: Colors.white)),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              backgroundColor: blue,
                              minimumSize: Size(130, 20)),
                          child: const Text('아니오',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
              child: const Icon(Icons.arrow_back))),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        // ---------------------------------------------------------- 일정
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('일정',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 5),
                child: Text('날짜',
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text('시간',
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 40, 5),
                child: Text(widget.reservationItem.date,
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                child: Text(reserveStartTime + ' ~ ' + reserveEndTime,
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
            ]),
          ],
        ),
        SizedBox(height: 10),
        const Divider(
          color: lightGrey,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        // ---------------------------------------------------------- 주차장 정보
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('주차장 정보',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 5),
                child: Text('장소',
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text('시간',
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 5), child: Text(' ')),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 5),
                child: Text('전화전호',
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text('요금',
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 40, 5),
                child: Text(parkingLotItem.address,
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                child: Text('평일 ' + parkingLotTime_week,
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 40, 5),
                child: Text('주말 ' + parkingLotTime_sun,
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 40, 5),
                child: Text(parkingLotNumber,
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                child: Text(parkingLotFee.toString() + ' 원',
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
            ]),
          ],
        ),
        SizedBox(height: 10),
        const Divider(
          color: lightGrey,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        // ---------------------------------------------------------- 예상결제금액
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('예상 결제 금액',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Text('최종요금',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
              child: Text('30분 ' + total.toString() + '원',
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                backgroundColor: lightGrey, minimumSize: Size(165, 20)),
            child: const Text('뒤로가기', style: TextStyle(color: Colors.black)),
          ),
          SizedBox(width: 10),
          TextButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                content: Text(
                  '성공적으로 예약이 완료되었습니다.',
                  style: TextStyle(fontSize: 15),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckReservation()));
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: blue, minimumSize: Size(300, 20)),
                    child:
                        const Text('확인', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            style: TextButton.styleFrom(
                backgroundColor: blue, minimumSize: Size(165, 20)),
            child: const Text('예약하기', style: TextStyle(color: Colors.white)),
          ),
        ])
      ]),
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
    );
  }
}
