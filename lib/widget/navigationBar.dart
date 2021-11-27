﻿import 'package:flutter/material.dart';
import 'package:parkinglot/pages/home.dart';
import 'package:parkinglot/pages/favorites.dart';
import 'package:parkinglot/pages/check_reservation.dart';
import 'package:parkinglot/pages/search.dart';
import 'package:parkinglot/pages/mypage.dart';
import 'package:parkinglot/pages/check_reservation.dart';

Widget NaviBarButtons(Size size, BuildContext context) {
  final double tabWidth = size.width * 0.2;
  return Container(
    height: 50,
    child: Row(
      children: <Widget>[
        ButtonTheme(
          minWidth: tabWidth,
          height: size.height * 0.1,
          child: RaisedButton(
            color: Colors.white,
            child: Icon(
              Icons.home_outlined,
              color: blue,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ),
        ButtonTheme(
          minWidth: tabWidth,
          height: size.height * 0.1,
          child: RaisedButton(
            color: Colors.white,
            child: Icon(
              Icons.search,
              color: blue,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
        ),
        ButtonTheme(
          minWidth: tabWidth,
          height: size.height * 0.1,
          child: RaisedButton(
            color: Colors.white,
            child: Icon(
              Icons.favorite_border,
              color: blue,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoritesPage()));
            },
          ),
        ),
        ButtonTheme(
          minWidth: tabWidth,
          height: size.height * 0.1,
          child: RaisedButton(
            color: Colors.white,
            child: Icon(
              Icons.receipt_outlined,
              color: blue,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckReservation()));
            },
          ),
        ),
        ButtonTheme(
          minWidth: tabWidth,
          height: size.height * 0.1,
          child: RaisedButton(
            color: Colors.white,
            child: Icon(
              Icons.person_outline,
              color: blue,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyPage()));
            },
          ),
        ),
      ],
    ),
  );
}