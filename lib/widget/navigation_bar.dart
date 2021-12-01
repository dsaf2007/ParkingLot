import 'package:flutter/material.dart';
import 'package:parkinglot/pages/check_reservation_admin.dart';
import 'package:parkinglot/pages/entrance_manager.dart';

import 'package:parkinglot/pages/home.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/pages/check_reservation.dart';
import 'package:parkinglot/pages/search.dart';
import 'package:parkinglot/pages/mypage.dart';

import 'package:parkinglot/providers/userdata.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:provider/provider.dart';

Widget NaviBarButtons(Size size, BuildContext context) {
  bool isAdmin = Provider.of<userData>(context, listen: false).isAdmin;

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
                Icon(Icons.home_outlined, color: darkGrey),
                SizedBox(height: 2),
                Text('홈', style: TextStyle(fontSize: 12, color: darkGrey)),
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
                Icon(Icons.search_outlined, color: darkGrey),
                SizedBox(height: 2),
                Text('검색', style: TextStyle(fontSize: 12, color: darkGrey)),
              ]),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
          ),
          isAdmin
              ? Padding(
                  padding: EdgeInsets.all(0),
                  child: TextButton(
                    child: Column(children: [
                      Icon(Icons.exit_to_app_rounded, color: darkGrey),
                      SizedBox(height: 2),
                      Text('입출차',
                          style: TextStyle(fontSize: 12, color: darkGrey)),
                    ]),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EntranceManager()));
                    },
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(0),
                  child: TextButton(
                    child: Column(children: [
                      Icon(Icons.favorite_outline_sharp, color: darkGrey),
                      SizedBox(height: 2),
                      Text('즐겨찾기',
                          style: TextStyle(fontSize: 12, color: darkGrey)),
                    ]),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavoritesPage()));
                    },
                  ),
                ),
          isAdmin
              ? Padding(
                  padding: EdgeInsets.all(0),
                  child: TextButton(
                    child: Column(children: [
                      Icon(Icons.receipt_outlined, color: darkGrey),
                      SizedBox(height: 2),
                      Text('예약내역',
                          style: TextStyle(fontSize: 12, color: darkGrey)),
                    ]),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckReservationAdmin()));
                    },
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(0),
                  child: TextButton(
                    child: Column(children: [
                      Icon(Icons.receipt_outlined, color: darkGrey),
                      SizedBox(height: 2),
                      Text('예약내역',
                          style: TextStyle(fontSize: 12, color: darkGrey)),
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
                Icon(Icons.person_outline, color: darkGrey),
                SizedBox(height: 2),
                Text('마이페이지', style: TextStyle(fontSize: 12, color: darkGrey)),
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