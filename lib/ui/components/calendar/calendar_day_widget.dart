import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

class CalendarDayWidget extends StatelessWidget {
  final CalendarDay day;
  final List<Memory> memories;

  const CalendarDayWidget(
    {
      super.key,
      required this.day,
      required this.memories
    }
  );

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
            Text(memories.length.toString())
          ],
        ),
      ),
    );
  }
}
