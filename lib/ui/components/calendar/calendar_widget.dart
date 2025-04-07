import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/calendar_day_widget.dart';

class CalendarWidget extends StatelessWidget {
  final Map<CalendarDay, List<Memory>> memoryMap;

  const CalendarWidget(
    {
      super.key,
      required this.memoryMap
    }
  );

  @override
  Widget build(BuildContext context) {
    final entries = memoryMap.entries.toList();
    List<List<CalendarDayWidget>> calendarRows = List.generate(
      (memoryMap.length / 7).floor(),
      (_) => []
    );

    for (int i = 0; i < memoryMap.length; i++) {
      final indexRow = i ~/ 7;

      calendarRows[indexRow].add(
        CalendarDayWidget(
          day: entries[i].key,
          memories: entries[i].value,
        )
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: calendarRows.map((calendaRow) => Row(mainAxisAlignment: MainAxisAlignment.center, children: calendaRow,)).toList(),
    );
  }
}
