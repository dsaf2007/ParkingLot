import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import '../util/colors.dart';
import './caledar_table.dart';

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
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text(parkingLotName),
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
            SizedBox(
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
                  child: const Text("초기화"),
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
                  child: const Text("선택완료"),
                  onPressed: () {
                    // 선택완료
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

  // void printData() {
  //   cardBody.printData();
  // }

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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                )),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 4,
                              child: Text(
                                dateSelectionMessage,
                                style: TextStyle(color: Colors.black),
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

class Card2 extends StatelessWidget {
  String timeSelectionMessage = "시간 선택";
  // void resetData() {}
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
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
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.black,
                                )),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 4,
                              child: Text(
                                timeSelectionMessage,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                collapsed: Container(),
                expanded: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Bill Date",
                                style: TextStyle(color: Colors.black)),
                            Text("15/06/2020",
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 2.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Adjustment",
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(".00", style: TextStyle(color: Colors.black)),
                          ],
                        ),
                        Divider(
                          color: Colors.blue,
                          thickness: 2.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total due",
                                style: TextStyle(color: Colors.blue)),
                            Text("413.27",
                                style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ],
                    ),
                  ),
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
    ));
  }
}
