import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:parkinglot/pages/approve_reservation.dart';
import 'package:parkinglot/widget/navigation_bar.dart';

import '../util/colors.dart';
import '../pages/calendar_table.dart';

class DateTimeSelection extends StatefulWidget {
  const DateTimeSelection({Key? key}) : super(key: key);

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
        pageBuilder: (_, __, ___) => DateTimeSelection(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NaviBarButtons(MediaQuery.of(context).size, context),
      appBar: AppBar(
          // 값 전달 받기
        title: Text(parkingLotName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back)
        )
      ),
      body: ExpandableTheme(
        data: const ExpandableThemeData(
          iconColor: Colors.white,
          useInkWell: true,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            Card1(),
            Card2(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:Size(MediaQuery.of(context).size.width * 0.45, 0),
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
                    )
                  ),
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
                    minimumSize:Size(MediaQuery.of(context).size.width * 0.45, 0),
                    padding: const EdgeInsets.all(10),
                    primary: blue,
                    onPrimary: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  child: const Text("선택완료",
                    style: TextStyle(
                      fontSize: 15,
                    )
                  ),
                  onPressed: () {
                    // 선택완료
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ApproveReservation())
                    );
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

const loremIpsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod";

List<ExpandableController> controllerList = [
  ExpandableController(),
  ExpandableController(),
];

int currentIndex = -1;

class Card1 extends StatelessWidget {
  final String dateSelectionMessage = "날짜 선택";
  CalendarTable cardBody = CalendarTable();

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
                        child: Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.black,
                                size: 35,
                              )
                            ),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 4,
                              child: Text(
                                dateSelectionMessage,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
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
      )
    );
  }
}

class Card2 extends StatefulWidget {
  const Card2({Key? key}) : super(key: key);

  @override
  _Card2State createState() => _Card2State();
}

class _Card2State extends State<Card2> {
  // MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
  //   final getColor = (Set<MaterialState> states) {
  //     if (states.contains(MaterialState.pressed)) {
  //       return colorPressed;
  //     } else {
  //       return color;
  //     }
  //   };
  //   return MaterialStateProperty.resolveWith(getColor);
  // }

  String timeSelectionMessage = "시간 선택";

  List<String> timeListAM = [];
  List<String> timeListPM = [];
  List<bool> isSelectedAM = [];
  List<bool> isSelectedPM = [];
  @override
  void initState() {
    for (int i = 6; i <= 11; i++) {
      timeListAM.add("$i:00");
      timeListAM.add("$i:30");
    }
    for (int i = 12; i <= 21; i++) {
      timeListPM.add("$i:00");
      timeListPM.add("$i:30");
    }
    isSelectedAM = List.filled(timeListAM.length, false);
    isSelectedPM = List.filled(timeListPM.length, false);
  }

  List<Row> _buildButtonRowsWithTimes(
    List<String> timeList, ButtonStyle buttonStyle) {
      int cols = 4;
      int rows = timeList.length ~/ cols;
      if (timeList.length % cols != 0) {
        for (int i = 0; i < timeList.length % cols; i++) {
          timeList.add("");
        }
        rows += 1;
      }
      List<ElevatedButton> allButtonList = []; // toggle button
      List<Row> buttonRowList = [];
      for (int i = 0; i < rows; i++) {
        List<ElevatedButton> buttonList = [];
        for (int j = 0; j < cols; j++) {
          int idx = i * cols + j;
          if (timeList[idx] == "") {
            buttonList.add(ElevatedButton(
              onPressed: () {},
              child: Container(),
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent, // 초록
                minimumSize: Size(MediaQuery.of(context).size.width * 0.19, 0),
              ),
            ));
          } 
          else {
            buttonList.add(ElevatedButton(
              style: buttonStyle,
              // style: ButtonStyle(
              //   foregroundColor: getColor(green, blue),
              //   backgroundColor: getColor(blue, green),
              // ),
              onPressed: (idx % 2 == 0) ? null : () {}, // is button valid?
              child: Text(
                timeList[idx],
              )
            )
          );
        }
        allButtonList.add(ElevatedButton(
            style: buttonStyle,
            // style: ButtonStyle(
            //   foregroundColor: getColor(green, blue),
            //   backgroundColor: getColor(blue, green),
            // ),
            onPressed: (idx % 2 == 0) ? null : () {}, // is button valid?
            child: Text(
              timeList[idx],
            )
          )
        );
      }
      Row buttonRow = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: buttonList,
      );
      buttonRowList.add(buttonRow);
    }
    return buttonRowList;
  }

  List<ElevatedButton> _buildButtonsWithTimes(
    List<String> timeList, ButtonStyle buttonStyle) {
      int cols = 4;
      int rows = timeList.length ~/ cols;
      if (timeList.length % cols != 0) {
        for (int i = 0; i < timeList.length % cols; i++) {
          timeList.add("");
        }
        rows += 1;
      }
      List<ElevatedButton> allButtonList = []; // toggle button
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          int idx = i * cols + j;
          if (timeList[idx] == "") break;
          allButtonList.add(ElevatedButton(
            style: buttonStyle,
            // style: ButtonStyle(
            //   foregroundColor: getColor(green, blue),
            //   backgroundColor: getColor(blue, green),
            // ),
            onPressed: (idx % 2 == 0) ? null : () {}, // is button valid?
            child: Text(
              timeList[idx],
            )
          )
        );
      }
    }
    return allButtonList;
  }

  // void resetData() {}
  @override
  Widget build(BuildContext context) {
    ButtonStyle timeOptionButtonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(MediaQuery.of(context).size.width * 0.19, 0),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      primary: green, // 초록
      onPrimary: Colors.white,
      textStyle: const TextStyle(
        fontSize: 16,
      ),
    );
    ButtonStyle emptyButtonStyle = ElevatedButton.styleFrom(
      minimumSize: Size(MediaQuery.of(context).size.width * 0.19, 0),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      primary: Colors.transparent, // 초록
      onPrimary: Colors.transparent,
      textStyle: const TextStyle(
        fontSize: 16,
      ),
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
                              )
                            ),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 4,
                              child: Text(
                                timeSelectionMessage,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
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
                        Column(
                          children: _buildButtonRowsWithTimes(
                              timeListAM, timeOptionButtonStyle),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("오후"),
                        Divider(
                          color: Colors.grey,
                        ),
                        Column(
                          children: _buildButtonRowsWithTimes(
                              timeListPM, timeOptionButtonStyle),
                        ),
                          // ToggleButtons(
                          //   children: _buildButtonsWithTimes(
                          //       timeListPM, timeOptionButtonStyle),
                          //   color: Colors.yellow,
                          //   selectedColor: Colors.red,
                          //   onPressed: (int index) {
                          //     int count = 0;
                          //     isSelectedPM.forEach((bool val) {
                          //       if (val) count++;
                          //     });

                          //     if (isSelectedPM[index] && count < 2) return;

                          //     setState(() {
                          //       isSelectedPM[index] = !isSelectedPM[index];
                          //     });
                          //   },
                          //   isSelected: isSelectedPM,
                          // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: const DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: green,
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
                              )
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: const DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "불가",
                                style: TextStyle(color: Colors.black),
                              )
                            ),
                          ],
                        ),
                      ],
                    )
                  ),
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
      )
    );
  }
}
