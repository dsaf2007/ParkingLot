import 'package:flutter/material.dart';
import 'package:parkinglot/pages/check_reservation_admin.dart';
import 'package:parkinglot/pages/home.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/pages/check_reservation.dart';
import 'package:parkinglot/pages/search.dart';
import 'package:parkinglot/pages/mypage.dart';

Widget NaviBarButtons(Size size, BuildContext context) {
  // 관리자 vs 고객 수정 가능
  bool isAdmin = true;

  return Container(
      color: Colors.white10,
      height: 80,
      child: Column(children: [
        const Divider(
          color: lightGrey,
          thickness: 1,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
            Widget>[
          Padding(
            padding: EdgeInsets.all(0),
            child: TextButton(
              child: Column(children: [
                Icon(
                  Icons.home_outlined,
                  color: darkGrey,
                ),
                SizedBox(height: 2),
                Text('홈',
                    style: TextStyle(
                        fontSize: 12,
                        color: darkGrey,
                        fontWeight: FontWeight.bold)),
              ]),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: TextButton(
              child: Column(children: [
                Icon(
                  Icons.search_outlined,
                  color: darkGrey,
                ),
                SizedBox(height: 2),
                Text('검색',
                    style: TextStyle(
                        fontSize: 12,
                        color: darkGrey,
                        fontWeight: FontWeight.bold)),
              ]),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: TextButton(
              child: Column(children: [
                Icon(
                  Icons.favorite_outline_sharp,
                  color: darkGrey,
                ),
                SizedBox(height: 2),
                Text('즐겨찾기',
                    style: TextStyle(
                        fontSize: 12,
                        color: darkGrey,
                        fontWeight: FontWeight.bold)),
              ]),
              onPressed: () {
                isAdmin
                    ? showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => const AlertDialog(
                              content: Text(
                                '관리자는 즐겨찾기 탭에 접근이 불가합니다.',
                                style: TextStyle(fontSize: 15),
                              ),
                            ))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavoritesPage()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: TextButton(
              child: Column(children: [
                Icon(
                  Icons.receipt_outlined,
                  color: darkGrey,
                ),
                SizedBox(height: 2),
                Text('예약내역',
                    style: TextStyle(
                        fontSize: 12,
                        color: darkGrey,
                        fontWeight: FontWeight.bold)),
              ]),
              onPressed: () {
                Navigator.pop(context);
                isAdmin
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckReservationAdmin()))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckReservation()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: TextButton(
              child: Column(children: [
                Icon(
                  Icons.person_outline,
                  color: darkGrey,
                ),
                SizedBox(height: 2),
                Text('마이페이지',
                    style: TextStyle(
                        fontSize: 12,
                        color: darkGrey,
                        fontWeight: FontWeight.bold)),
              ]),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyPage()));
              },
            ),
          ),
        ])
      ]));
}
