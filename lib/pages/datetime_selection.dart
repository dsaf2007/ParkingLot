import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:intl/intl.dart';
import 'package:parkinglot/pages/approve_reservation.dart';
import 'package:parkinglot/widget/navigation_bar.dart';

import '../util/colors.dart';
import '../pages/calendar_table.dart';

import '../models/parkinglot_item.dart';
import '../models/reservation_item.dart';

class DateTimeSelection extends StatefulWidget {
  final ParkingLotItem parkingLotItem;
  const DateTimeSelection({Key? key, required this.parkingLotItem})
      : super(key: key);

  @override
  _DateTimeSelectionState createState() => _DateTimeSelectionState();
}

class _DateTimeSelectionState extends State<DateTimeSelection> {
  final String parkingLotName = "대한극장주차장";
  final String selectedDay = "11.19. (금)";

  void _reset() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => DateTimeSelection(
          parkingLotItem: widget.parkingLotItem,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ParkingLotItem parkingLotItem = widget.parkingLotItem;
    DateTime reservationDate;
    ReservationItem reservationInfo = ReservationItem(
        parkingLotItem, "No Data", "No Data", "No Data", "No Data", false);

    return Scaffold(
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
      appBar: AppBar(
        // 값 전달 받기
        title: Text(parkingLotItem.name,
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
            child: const Icon(Icons.arrow_back)),
      ),
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.white,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Card1(
              onSelectDate: (String date) {
                reservationInfo.date = date;
              },
            ),
            Card2(
              onSelectTime: (
                String startTime,
                String endTime,
                int times,
              ) {
                reservationInfo.start_time = startTime;
                reservationInfo.end_time = endTime;
                reservationInfo.total_fee =
                    (times * parkingLotItem.fee).toString();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.45, 0),
                    padding: const EdgeInsets.all(10),
                    primary: Colors.grey,
                    onPrimary: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  child: const Text("초기화",
                      style: TextStyle(
                        fontSize: 15,
                      )),
                  onPressed: () {
                    // 초기화
                    // printData();
                    _reset();
                  },
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.45, 0),
                    padding: const EdgeInsets.all(10),
                    primary: blue,
                    onPrimary: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  child: const Text(
                    "선택완료",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    // 선택완료
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApproveReservation(
                                  // todo: not parkinglotItem, but ReservationItem
                                  // build ReservationItem data and send!!
                                  reservationItem: reservationInfo,
                                )));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

List<ExpandableController> controllerList = [
  ExpandableController(),
  ExpandableController(),
];

int currentIndex = -1;

class Card1 extends StatefulWidget {
  Card1({Key? key, required this.onSelectDate}) : super(key: key);
  Function(String) onSelectDate;
  // to get data from calendar
  late DateTime selectedDay;
  late DateTime selectedDayForHeader;
  // for callback
  late DateTime reservationDay;
  @override
  _Card1State createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  String dateSelectionMessage = "날짜 선택";

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    CalendarTable cardBody = CalendarTable(
      onSelectDay: (selectedDay) {
        final String formatted = formatter.format(selectedDay);
        widget.onSelectDate(formatted);
        setState(() {
          // dateSelectionMessage = formatted;
          dateSelectionMessage = formatted;
        });
      },
    );

    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                controller: controllerList[0],
                theme: const ExpandableThemeData(
                  iconColor: Colors.black, // expand icon (down arrow)
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: InkWell(
                  onTap: () {
                    currentIndex = 0;
                    for (int i = 0; i < controllerList.length; i++) {
                      if (i == currentIndex) {
                        controllerList[i].expanded = true;
                      } else {
                        controllerList[i].expanded = false;
                      }
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                  size: 35,
                                )),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                dateSelectionMessage,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                collapsed: Container(),
                expanded: cardBody,
                builder: (_, collapsed, expanded) {
                  return Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class Card2 extends StatefulWidget {
  Card2({Key? key, required this.onSelectTime}) : super(key: key);
  Function(String, String, int) onSelectTime;
  // to get data from calendar
  late String startTime;
  // for callback
  late String endTime;

  @override
  _Card2State createState() => _Card2State();
}

class _Card2State extends State<Card2> {
  String timeSelectionHeader = "시간 선택";

  final int openTime = 6;
  final int closeTime = 24;
  int startTimeIndex = -1;
  int endTimeIndex = -1;
  int lastSelectedTimeIndex = -1;
  bool isSelectionDone = false;
  // structure change
  List<String> timeStringList = [];
  List<bool> isSelected = [];
  List<bool> isDisabled = [];
  Color selectColor = selectBlue;

  ButtonStyle buildButtonStyle(Color color) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(MediaQuery.of(context).size.width * 0.19, 0),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      primary: color, // 초록
      textStyle: const TextStyle(
        fontSize: 16,
      ),
    );
    return buttonStyle;
  }

  @override
  void initState() {
    // new --------------
    for (int i = openTime; i < closeTime; i++) {
      timeStringList.add("$i:00");
      timeStringList.add("$i:30");
    }
    isSelected = List.filled(timeStringList.length, false);
    // todo: real availiable time update
    isDisabled = List.filled(timeStringList.length, false);
    isDisabled[0] = true;
    isDisabled[1] = true;
  }

  String formatEndTime(int endIdx) {
    String endTime;
    if (endIdx == timeStringList.length - 1) {
      endTime = "$closeTime:00";
    } else {
      endTime = timeStringList[endIdx + 1];
    }
    return endTime;
  }

  String _buildTimeRangeString(int startIdx, int endIdx) {
    String startTime = timeStringList[startIdx];
    String endTime = formatEndTime(endIdx);
    return startTime + " ~ " + endTime;
  }

  void selectTime(int index) {
    if (isDisabled[index]) {
      isSelected = List.filled(isSelected.length, false);
      timeSelectionHeader = "시간 선택";
      return;
    }
    // 첫 선택
    if (lastSelectedTimeIndex < 0) {
      isSelected[index] = true;
      widget.onSelectTime(timeStringList[index], formatEndTime(index), 1);
      timeSelectionHeader = _buildTimeRangeString(index, index);
    } // 새로운 시작 날짜 재선택
    else if (isSelectionDone ||
        (index < lastSelectedTimeIndex) ||
        (index == lastSelectedTimeIndex)) {
      // print("select:$index, last:$lastSelectedTimeIndex");
      isSelected = List.filled(isSelected.length, false);
      isSelected[index] = true;
      isSelectionDone = false;

      widget.onSelectTime(timeStringList[index], formatEndTime(index), 1);
      timeSelectionHeader = _buildTimeRangeString(index, index);
    } // 다중 선택
    else {
      for (int i = lastSelectedTimeIndex; i <= index; i++) {
        isSelected[i] = true;
      }
      isSelectionDone = true;
      // pass to approval
      startTimeIndex = lastSelectedTimeIndex;
      endTimeIndex = index;
      widget.onSelectTime(timeStringList[startTimeIndex],
          formatEndTime(endTimeIndex), endTimeIndex - startTimeIndex + 1);
      timeSelectionHeader = _buildTimeRangeString(startTimeIndex, endTimeIndex);
    }
    if (isSelected[index]) {
      lastSelectedTimeIndex = index;
    }
  }

  List<InkWell> _buildButtonsWithTimesPM(List<String> timeList) {
    List<InkWell> allButtonList = []; // toggle button
    for (int i = 0; i < timeList.length; i++) {
      // 오전 개수 만큼 더해야 전체 시간 리스트의 오후 인덱스
      final int PM = 2 * (12 - openTime);
      Color defaultButtonColor = isDisabled[i + PM] ? mediumGrey : lightBlue;
      allButtonList.add(InkWell(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.19, 0),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              primary:
                  isSelected[i + PM] ? selectColor : defaultButtonColor, // 초록
              textStyle: const TextStyle(
                fontSize: 16,
              ),
            ),
            onPressed: () {
              setState(() {
                selectTime(i + PM);
              });
            },
            child: Text(timeList[i])),
      ));
    }
    return allButtonList;
  }

  List<InkWell> _buildButtonsWithTimesAM(List<String> timeList) {
    List<InkWell> allButtonList = []; // toggle button
    for (int i = 0; i < timeList.length; i++) {
      if (timeList[i] == "") break;
      Color defaultButtonColor = isDisabled[i] ? mediumGrey : lightBlue;
      allButtonList.add(InkWell(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.19, 0),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              primary: isSelected[i] ? selectColor : defaultButtonColor, // 초록
              textStyle: const TextStyle(
                fontSize: 16,
              ),
            ),
            onPressed: () {
              setState(() {
                selectTime(i);
              });
            },
            child: Text(timeList[i])),
      ));
    }
    return allButtonList;
  }

  CustomScrollView buildToggleButtonScrollView(bool isAM) {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(5),
          sliver: SliverGrid.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
              childAspectRatio: 2.0,
              children: isAM
                  ? _buildButtonsWithTimesAM(
                      timeStringList.sublist(0, 2 * (12 - openTime)))
                  : _buildButtonsWithTimesPM(timeStringList.sublist(
                      2 * (12 - openTime), timeStringList.length))),
        ),
      ],
    );
  }

  // void resetData() {}
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                controller: controllerList[1],
                theme: const ExpandableThemeData(
                  iconColor: Colors.black,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: InkWell(
                  onTap: () {
                    currentIndex = 1;
                    for (int i = 0; i < controllerList.length; i++) {
                      if (i == currentIndex) {
                        controllerList[i].expanded = true;
                      } else {
                        controllerList[i].expanded = false;
                      }
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.access_alarm,
                                  color: Colors.black,
                                  size: 35,
                                )),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 4,
                              child: Text(
                                timeSelectionHeader,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                collapsed: Container(),
                expanded: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Text("오전"),
                        Divider(
                          color: Colors.grey,
                        ),
                        // Column(
                        //   children: _buildButtonRowsWithTimes(
                        //       timeListAM, timeOptionButtonStyle),
                        // ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: buildToggleButtonScrollView(true),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("오후"),
                        Divider(
                          color: Colors.grey,
                        ),
                        // Column(
                        //   children: _buildButtonsWithTimesPM(timeListPM),
                        // ),
                        // Container(
                        //   child: buildToggleButtonScrollView(timeListPM),
                        // ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: buildToggleButtonScrollView(false),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: const DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: lightBlue,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "선택가능",
                                  style: TextStyle(color: Colors.black),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: const DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: mediumGrey,
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "불가",
                                  style: TextStyle(color: Colors.black),
                                )),
                          ],
                        ),
                      ],
                    )),
                builder: (_, collapsed, expanded) {
                  return Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
