import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/calendar_day_widget.dart';

class CalendarWidget extends StatelessWidget {
  final List<CalendarDay> days;

  const CalendarWidget(
    {
      super.key,
      required this.days
    }
  );

  @override
  Widget build(BuildContext context) {
    List<List<CalendarDayWidget>> calendarRows = List.generate(
      (days.length / 7).floor(),
      (_) => []
    );
    for (int i = 0; i < days.length; i++) {
      final indexRow = i ~/ 7;
      calendarRows[indexRow].add(CalendarDayWidget(day: DateFormat('d').format(days[i].date), gapType: days[i].gapType));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: calendarRows.map((calendaRow) => Row(mainAxisAlignment: MainAxisAlignment.center, children: calendaRow,)).toList(),
    );
  }
}
