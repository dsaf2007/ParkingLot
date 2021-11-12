// alarmList.dart
import 'package:flutter/material.dart';
import '../util/colors.dart';
import 'package:parkinglot/widget/navigationBar.dart';

class AlarmList extends StatefulWidget {
  @override
  _AlarmListState createState() => _AlarmListState();
}

class _AlarmListState extends State<AlarmList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            // leading: Icon(Icons.arrow_back),
            title: Text("알림함"),
            backgroundColor: blue,
          ),
          body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.notifications_off, size: 50),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "알림이 없습니다.",
                    style: TextStyle(fontSize: 20),
                  )
                ]),
          )),
    );
  }
}
