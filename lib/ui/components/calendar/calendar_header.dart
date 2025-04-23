import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/calendar_week_day_header.dart';

class CalendarHeader extends StatelessWidget {
  final List<CalendarDay> days;
  final double itemHeight;
  final double itemWidth;

  const CalendarHeader(
    {
      super.key,
      required this.days,
      this.itemHeight = 90,
      this.itemWidth = 45
    }
  );

  @override
  Widget build(BuildContext context) {
    final weekDays = days.take(7).map((day) => CalendarWeekDayHeader(
        weekDayName: DateFormat('EEE').format(day.date),
        height: itemHeight,
        width: itemWidth,
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...weekDays
      ],
    );
  }
}
