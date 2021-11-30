import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:parkinglot/models/parkinglot_item.dart';
import 'package:parkinglot/models/reservation_item.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/pages/mypage.dart';
import 'package:parkinglot/widget/navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'check_reservation.dart';
import 'package:parkinglot/providers/parkinglotdata.dart';
import 'package:parkinglot/providers/userdata.dart';
import 'package:parkinglot/providers/reservationdata.dart';
import 'package:provider/provider.dart';


class ApproveReservation extends StatefulWidget {
  final ReservationItem reservationItem;
  const ApproveReservation({Key? key, required this.reservationItem})
      : super(key: key);

  @override
  _ApproveReservationState createState() => _ApproveReservationState();
}

class _ApproveReservationState extends State<ApproveReservation> {
/*<<<<<<< kkm
  String reserveDate = '[TEST]2021.11.19 (금)';

  String parkingLotTime_week = '[TEST]00:00~24:00';
  String parkingLotTime_sat = '[TEST]00:00~24:00';
  String parkingLotTime_sun = '[TEST]00:00~24:00';

  // String parkingLotNumber = '[TEST]02-1234-1234';
  // int parkingLotFee = 800;
  // int total = 1600;
  final baseTime = 30;
  @override
  Widget build(BuildContext context) {
    ParkingLotItem parkingLotItem = widget.reservationItem.parkingLotItem;
    TextStyle bigHeaderTextStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    TextStyle smallHeaderTextStyle = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
=======*/
  // 얘네도 추후 datetime_selection에서 받아와 수정 필요함.=====================================
  String reserveDate = '2021.11.19 (금)';
  String reserveStartTime = '09:00';
  String reserveEndTime = '10:00';

  @override
  Widget build(BuildContext context) {
    ParkingLotItem parkinglotdata = //Provider에서 ParkingLotItem Load
        Provider.of<parkingLotData>(context, listen: false).lotData;

    String parkingLotName = parkinglotdata.name;
    String parkingLotAddress = parkinglotdata.address;
    //주차장 정보- 운영 시간에서 int->String 형변환+두자리수로 표기
    String parkingLotTime_weekday =
        parkinglotdata.weekday_begin.toString().padLeft(2, '0') +
            ':' +
            parkinglotdata.weekday_end.toString().padLeft(2, '0');
    String parkingLotTime_weekend =
        parkinglotdata.weekend_begin.toString().padLeft(2, '0') +
            ':' +
            parkinglotdata.weekend_end.toString().padLeft(2, '0');
    String parkingLotNumber = parkinglotdata.telephone;
    int parkingLotFee = parkinglotdata.fee;
    int total = 1600; //-추후 값 받아와 계산 후 저장/출력 필요================================
    int testmin = 50;
    String username = Provider.of<userData>(context, listen: false).name;
    int total_space = parkinglotdata.total_space;
//>>>>>>> cdg_psh
    return Scaffold(
      appBar: AppBar(
          // 값 전달 받기
          title: Text(parkingLotItem.name, style: bigHeaderTextStyle),
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
          child: Text('일정', style: bigHeaderTextStyle),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 5),
                child: Text('날짜', style: smallHeaderTextStyle),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text('시간', style: smallHeaderTextStyle),
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
                child: Text(
                    widget.reservationItem.start_time +
                        ' ~ ' +
                        widget.reservationItem.end_time,
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
          child: Text('주차장 정보', style: bigHeaderTextStyle),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 5),
                child: Text('장소', style: smallHeaderTextStyle),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text('시간', style: smallHeaderTextStyle),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 5), child: Text(' ')),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 5),
                child: Text('전화번호', style: smallHeaderTextStyle),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                child: Text('요금 ($baseTime분 당)', style: smallHeaderTextStyle),
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
                child: Text('평일 ' + parkingLotTime_weekday,
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 40, 5),
                child: Text('주말 ' + parkingLotTime_weekend,
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 40, 5),
                child: Text(
                    parkingLotItem.telephone.isEmpty
                        ? "전화번호 없음"
                        : parkingLotItem.telephone,
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                child: Text('${parkingLotItem.fee} 원',
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
          child: Text('예상 결제 금액', style: bigHeaderTextStyle),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
              child: Text('최종요금', style: smallHeaderTextStyle),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
              child: Text('${widget.reservationItem.total_fee} 원',
                  style: TextStyle(
                    fontSize: 18,
                    color: selectBlue,
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
                content: const Text(
                  '성공적으로 예약이 완료되었습니다.',
                  style: TextStyle(fontSize: 15),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      //----- push to DB; 추후 예약 진행하는 주차장 정보를 받아와 변경 필요 -----
                      // Provider로 data 받아옴
                      int test_total_space = 50;
                      FirebaseFirestore.instance
                          .collection("Reservation")
                          .doc(username +
                              '_' +
                              parkinglotdata.name +
                              '_' +
                              reserveDate + //#
                              '_' +
                              reserveStartTime) //#
                          .set({
                        "name": parkinglotdata.name,
                        "address": parkinglotdata.address,
                        "number": parkinglotdata.telephone,
                        "fee": parkinglotdata.fee,
                        "total_space": parkinglotdata.total_space,
                        "date": reserveDate, //#
                        "start_time": reserveStartTime, //#
                        "end_time": reserveEndTime, //#
                        "fee_for_pay": total, //#
                        "user_id": username,
                        "code": parkinglotdata.code,
                        "is_current": true,
                      });
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
