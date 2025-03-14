import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/calendar_week_day_header.dart';

class CalendarHeader extends StatelessWidget {
  final List<CalendarDay> days;
  const CalendarHeader(
    {
      super.key,
      required this.days
    }
  );

  @override
  Widget build(BuildContext context) {
    final weekDays = days.take(7).map((day) => CalendarWeekDayHeader(weekDayName: DateFormat('EEE').format(day.date)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...weekDays
      ],
    );
  }
}
