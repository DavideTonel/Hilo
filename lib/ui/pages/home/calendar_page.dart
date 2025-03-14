import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_tracker.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/calendar_control_bar.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/calendar_header.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/calendar_widget.dart';

class CalendarPage extends StatelessWidget {
  final CalendarTracker calendarTracker = CalendarTracker(3, 2025);

  CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final days = calendarTracker.getDaysCurrentMonthWithGap();
    return Column(
      children: [
        CalendarControlBar(),
        CalendarHeader(days: days),
        CalendarWidget(days: days),
      ],
    );
  }
}
