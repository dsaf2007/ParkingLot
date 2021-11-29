import 'package:flutter/material.dart';
import 'package:parkinglot/pages/home.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/pages/check_reservation.dart';
import 'package:parkinglot/pages/search.dart';
import 'package:parkinglot/pages/mypage.dart';

Widget NaviBarButtons(Size size, BuildContext context) {
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
                Icon(Icons.home_outlined),
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
                Icon(Icons.search_outlined),
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
                Icon(Icons.favorite_outline_sharp),
                SizedBox(height: 2),
                Text('즐겨찾기',
                    style: TextStyle(
                        fontSize: 12,
                        color: darkGrey,
                        fontWeight: FontWeight.bold)),
              ]),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoritesPage()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: TextButton(
              child: Column(children: [
                Icon(Icons.receipt_outlined),
                SizedBox(height: 2),
                Text('예약내역',
                    style: TextStyle(
                        fontSize: 12,
                        color: darkGrey,
                        fontWeight: FontWeight.bold)),
              ]),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
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
                Icon(Icons.person_outline),
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
