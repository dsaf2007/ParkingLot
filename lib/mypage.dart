import 'package:flutter/material.dart';
import './util/colors.dart';
import 'package:parkinglot/pages/alarm_list.dart';

// move to util/colors.dart later..

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    final String userName = "정동구"; // later.. user.name
    final String userPhoneNumber = "010-****-1234"; // user.phoneNumber
    bool isAdmin = true;

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // SizedBox(
                      //   height: 50,
                      // ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(userName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          isAdmin
                              ? Text("관리자",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ))
                              : Text(""),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(userPhoneNumber, style: TextStyle(fontSize: 18)),
                      // SizedBox(
                      //   height: 30,
                      // )
                    ],
                  ),
                ),
                Divider(
                  thickness: 5.0,
                  color: lightGrey,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, left: 10),
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView(
                      // itemExtent: 55, // height of list tile
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.sticky_note_2_outlined),
                          title: Text("서비스 사용방법",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        ListTile(
                          leading: Icon(Icons.favorite_border_rounded),
                          title: Text("즐겨찾기",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        ListTile(
                          leading: Icon(Icons.notifications_none),
                          title: Text("알림함",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          onTap: () {
                            // 알림함 페이지로 이동
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AlarmList()),
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text("회원정보 수정",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        ListTile(
                          leading: Icon(Icons.people),
                          title: Text("팀 소개",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        ListTile(
                            leading: Icon(Icons.local_phone_outlined),
                            title: Text("고객센터",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ))),
                        ListTile(
                          leading: Icon(Icons.help_outline),
                          title: Text("FAQ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "로그아웃",
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("|",
                        style: TextStyle(
                          color: Colors.black54,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Text("회원탈퇴"),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
