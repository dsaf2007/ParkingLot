// alarmList.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:parkinglot/widget/navigation_bar.dart';

import 'package:parkinglot/util/helper.dart';

class EntranceManager extends StatefulWidget {
  @override
  _EntraceManagerState createState() => _EntraceManagerState();
}

class _EntraceManagerState extends State<EntranceManager> {
  final int reservationIdLength = 6;

  bool isValidReservation(String reservationId, List<String> list) {
    // 존재하는 예약번호인지?
    bool isValid = false;
    if (list.contains(reservationId)) {
      isValid = true;
    }
    return isValid;
  }

  Future<void> CarIn(String id) async {
    var doc_id = '';
    var doc_parse = [];
    await FirebaseFirestore.instance
        .collection("Reservation")
        .where("reservation_code", isEqualTo: id)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        doc_id = doc.reference.path.toString();
        doc_parse = doc_id.split("/");
        return FirebaseFirestore.instance
            .collection("Reservation")
            .doc(doc_parse[1])
            .update({'is_parked': true, 'is_current': true})
            .then((value) => print("is_parked Updated"))
            .catchError((error) => print("Failed to update Car In: $error"));
      }
    });
  }

  Future<void> CarOut(String id) async {
    var doc_id = '';
    var doc_parse = [];
    await FirebaseFirestore.instance
        .collection("Reservation")
        .where("reservation_code", isEqualTo: id)
        .get()
        .then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        doc_id = doc.reference.path.toString();
        doc_parse = doc_id.split("/");
        return FirebaseFirestore.instance
            .collection("Reservation")
            .doc(doc_parse[1])
            .update({'is_parked': false, 'is_current': false})
            .then((value) => print("is_parked Updated"))
            .catchError((error) => print("Failed to update Car out: $error"));
      }
    });
  }

  bool isValid = false;
  String reservation_code = '';

  final Stream<QuerySnapshot> reservation = FirebaseFirestore.instance
      .collection("Reservation")
      .orderBy('code')
      .snapshots(includeMetadataChanges: true);

  List<String> reservation_code_list = [];

  Text informValidation = Text("");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Size doubleButtonSize = Size(size.width * 0.4, 50);
    return StreamBuilder<QuerySnapshot>(
        stream: reservation,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {}
          if (snapshot.connectionState == ConnectionState.waiting) {}

          for (var doc in snapshot.data!.docs) {
            reservation_code_list.add(doc["reservation_code"]);
          }
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                    // 값 전달 받기
                    title: Text('입출차 관리 페이지',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    centerTitle: true,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    leading: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back))),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                            onChanged: (_reservationId) {
                              setState(() {
                                if (_reservationId.isEmpty) {
                                  informValidation = Text(
                                    "예약번호를 입력하세요.",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: mediumGrey,
                                    ),
                                  );
                                } else if (isValidReservation(
                                    _reservationId, reservation_code_list)) {
                                  isValid = true;
                                  reservation_code = _reservationId;
                                  informValidation = Text("유효한 예약번호입니다.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: blue,
                                      ));
                                } else {
                                  isValid = false;
                                  informValidation = Text("올바르지 않은 예약번호입니다.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                      ));
                                }
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 10),
                              border: OutlineInputBorder(),
                            )),
                        informValidation,
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ElevatedButton(
                              // todo: 입차 시퀀스
                              // (1) 예약여부 확인 -> 승인 또는 거절
                              // (2) 승인 시, 예약정보의 입차시간 기록
                              onPressed: () {
                                if (isValid == true) {
                                  CarIn(reservation_code);
                                }
                              },
                              child: Text(
                                "입 차",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: buildDoubleButtonStyle(
                                  blue, doubleButtonSize),
                            ),
                            ElevatedButton(
                              // todo: 출차 시퀀스
                              // (1) 요금 계산
                              // (2) 출차 승인
                              onPressed: () {
                                if (isValid == true) {
                                  CarOut(reservation_code);
                                }
                              },
                              child: Text(
                                "출 차",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: buildDoubleButtonStyle(
                                  darkGrey, doubleButtonSize),
                            ),
                          ],
                        )
                      ]),
                )),
          );
        });
  }
}
