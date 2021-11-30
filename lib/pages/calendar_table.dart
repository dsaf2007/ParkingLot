// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:parkinglot/util/colors.dart';
import 'package:table_calendar/table_calendar.dart';

import '../util/table_utils.dart';

class CalendarTable extends StatefulWidget {
  CalendarTable({required this.onSelectDay});
  Function(DateTime) onSelectDay;
  @override
  _CalendarTableState createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: const CalendarStyle(
        todayDecoration:
            const BoxDecoration(color: superLightBlue, shape: BoxShape.circle),
        disabledTextStyle:
            const TextStyle(color: Color.fromRGBO(220, 220, 220, 1.0)),
        selectedDecoration:
            const BoxDecoration(color: selectBlue, shape: BoxShape.circle),
      ),
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
      ),
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            widget.onSelectDay(_selectedDay!);
          });
        }
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          // Call `setState()` when updating calendar format
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    );
  }
}
