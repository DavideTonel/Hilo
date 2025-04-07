import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';

class CalendarDayEmptyWidget extends StatelessWidget {
  final CalendarDay day;

  const CalendarDayEmptyWidget({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 90,
        width: 45,
        color: day.gapType == CalendarDayGapType.currentMonth ? Colors.blue : Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(day.date.day.toString()),
          ],
        ),
      ),
    );
  }
}
