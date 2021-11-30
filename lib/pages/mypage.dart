import 'package:flutter/material.dart';
import 'package:parkinglot/pages/alarm_list.dart';
import 'package:parkinglot/pages/edit_profile_checkpassword.dart';
import 'package:parkinglot/pages/entrance_manager.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/pages/manage_parkinglot.dart';
import 'package:parkinglot/pages/signin.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:parkinglot/providers/userdata.dart';
import 'package:parkinglot/widget/navigation_bar.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    String userName = Provider.of<userData>(context, listen: false).name;
    String userPhoneNumber =
        Provider.of<userData>(context, listen: false).telephone;
    bool isAdmin = Provider.of<userData>(context, listen: false).isAdmin;

    print(isAdmin);
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
                              : Text(
                                  "",
                                ),
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
                        isAdmin
                            ? ListTile(
                                leading: Icon(Icons.sticky_note_2_outlined),
                                title: Text("주차장관리",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ManageParkingLot()),
                                  );
                                },
                              )
                            : ListTile(
                                leading: Icon(Icons.sticky_note_2_outlined),
                                title: Text("서비스 사용방법",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                        isAdmin
                            ? Container()
                            : ListTile(
                                leading: Icon(Icons.favorite_border_rounded),
                                title: Text("즐겨찾기",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FavoritesPage()),
                                  );
                                }),
                        ListTile(
                          leading: Icon(Icons.notifications_none),
                          title: Text("알림함",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AlarmList()),
                            );
                          },
                        ),
                        isAdmin
                            ? Container()
                            : ListTile(
                                leading: Icon(Icons.person),
                                title: Text("회원정보 수정",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FixProfileCKPW()));
                                },
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
                        isAdmin
                            ? ListTile(
                                leading: Icon(Icons.exit_to_app_rounded),
                                title: Text("입출차 관리",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EntranceManager()));
                                },
                              )
                            : Container(),
                      ]),
                ),
                !isAdmin
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()),
                              );
                            },
                            child: Text("로그아웃"),
                          ),
                          Text("|",
                              style: TextStyle(
                                color: Colors.black54,
                              )),
                          TextButton(
                            onPressed: () {},
                            child: Text("회원탈퇴"),
                          ),
                        ],
                      )
                    : Container()
              ]),
        ),
        bottomNavigationBar:
            NaviBarButtons(MediaQuery.of(context).size, context),
      ),
    );
  }
}
