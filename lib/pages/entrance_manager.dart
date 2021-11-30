// alarmList.dart
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

  bool isValidReservation(String reservationId) {
    // 존재하는 예약번호인지?
    bool isValid = false;
    if (reservationId.length > reservationIdLength) {
      isValid = true;
    }
    return isValid;
  }

  Text informValidation = Text("");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Size doubleButtonSize = Size(size.width * 0.4, 50);

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
                          } else if (isValidReservation(_reservationId)) {
                            informValidation = Text("유효한 예약번호입니다.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: blue,
                                ));
                          } else {
                            informValidation = Text("올바르지 않은 예약번호입니다.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                ));
                          }
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
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
                          
                        },
                        child: Text(
                          "입 차",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: buildDoubleButtonStyle(blue, doubleButtonSize),
                      ),
                      ElevatedButton(
                        // todo: 출차 시퀀스
                        // (1) 요금 계산
                        // (2) 출차 승인
                        onPressed: () {},
                        child: Text(
                          "출 차",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style:
                            buildDoubleButtonStyle(darkGrey, doubleButtonSize),
                      ),
                    ],
                  )
                ]),
          )),
    );
  }
}
