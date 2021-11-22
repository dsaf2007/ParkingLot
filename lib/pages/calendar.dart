// calendar widget
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:parkinglot/util/colors.dart';

class Calendar extends StatefulWidget {
  Calendar({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _CalendarState createState() => new _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());

  DateTime _targetDateTime = DateTime(2021, 11, 30);
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(1000)),
      border: Border.all(color: Colors.blue, width: 2.0)
    ),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  // EventList<Event> _markedDateMap = new EventList<Event>(
  //   events: {
  //     new DateTime(2021, 11, 10): [
  //       new Event(
  //         date: new DateTime(2021, 11, 10),
  //         title: 'Event 1',
  //         icon: _eventIcon,
  //         dot: Container(
  //           margin: EdgeInsets.symmetric(horizontal: 1.0),
  //           color: Colors.red,
  //           height: 5.0,
  //           width: 5.0,
  //         ),
  //       ),
  //     ],
  //   },
  // );

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    // _markedDateMap.add(
    //     new DateTime(2021, 11, 25),
    //     new Event(
    //       date: new DateTime(2021, 11, 25),
    //       title: 'Event 5',
    //       icon: _eventIcon,
    //     ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      // todayBorderColor: Colors.white,
      onDayPressed: (date, events) {
        setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      weekFormat: false,
//      firstDayOfWeek: 4,
      // markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayBorderColor: Colors.transparent,
      todayButtonColor: Colors.transparent,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 90)),
      maxSelectedDate: _currentDate.add(Duration(days: 90)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
      weekdayTextStyle: TextStyle(
        color: Colors.black,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //custom icon
            // This trailing comma makes auto-formatting nicer for build methods.
            //custom icon without header
            Container(
              margin: EdgeInsets.only(
                top: 30.0,
                bottom: 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _currentMonth,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )
                  ),
                  FlatButton(
                    child: Text('PREV'),
                    onPressed: () {
                      setState(() {
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month - 1);
                        _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                      });
                    },
                  ),
                  FlatButton(
                    child: Text('NEXT'),
                    onPressed: () {
                      setState(() {
                        _targetDateTime = DateTime(
                            _targetDateTime.year, _targetDateTime.month + 1);
                        _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                      });
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: _calendarCarouselNoHeader,
            ), //
          ],
        ),
      )
    );
  }
}