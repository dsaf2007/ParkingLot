import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkinglot/pages/mypage.dart';
import 'package:parkinglot/widget/navigationBar.dart';

import 'CheckReservation.dart';

class  ApproveReservation extends StatefulWidget {
  const ApproveReservation({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ApproveReservationState createState() => _ApproveReservationState();
}

class _ApproveReservationState extends State<ApproveReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            // 값 전달 받기
            title: const Text('대한극장',
              style:TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            leading: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.arrow_back)
            )
      ),
      body:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20.0),
                child:
                  Text('일정',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Text('날짜',
                      style: TextStyle(
                        fontSize: 15,
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(165, 0, 0, 0),
                  child: Text('2021.11.19 (금)',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 15,
                      )
                  ),
                ),
             ]
            ),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text('시간',
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                    child: Text('오전 '+'9:00'+' ~ '+'10:00',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                ]
            ),
            SizedBox(height: 15),
            const Divider(
              color : lightGrey,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child:
              Text('주차장 정보',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text('장소',
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(165, 0, 0, 0),
                    child: Text('서울 중구 필동 2가',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                ]
            ),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text('시간',
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                    child: Text('평일 '+'00:00'+' ~ '+'24:00',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text('',
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                    child: Text('토요일 '+'00:00'+' ~ '+'24:00',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                ]
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text('',
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                    child: Text('일요일 '+'00:00'+' ~ '+'24:00',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                ]
            ),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text('전화번호',
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                    child: Text('02-000-0000',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                ]
            ),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text('요금',
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                    child: Text('30분 '+'800'+ '원',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                ]
            ),
            SizedBox(height: 15),

            const Divider(
              color : lightGrey,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child:
              Text('예상 결제 금액',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
              ),
            ),            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text('최종 요금',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(150, 0, 0, 0),
                    child: Text('30분 '+'800'+ '원',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 15,
                        )
                    ),
                  ),
                ]
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {  },
                    style: TextButton.styleFrom(backgroundColor: lightGrey, minimumSize: Size(165,20)),
                    child: const Text('뒤로가기', style: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: () =>
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(
                                content: Text('성공적으로 예약이 완료되었습니다.', style: TextStyle(fontSize: 15),),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => CheckReservation(title: '',)));
                                    },
                                    style: TextButton.styleFrom(backgroundColor: blue, minimumSize: Size(300,20)),
                                    child: const Text('확인', style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                        ),
                    style: TextButton.styleFrom(backgroundColor: blue, minimumSize: Size(165,20)),
                    child: const Text('예약하기', style: TextStyle(color: Colors.white)),
                  ),
              ]
            )
          ]
      ),
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
    );
  }
}