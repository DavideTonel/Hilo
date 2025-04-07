import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_tracker.dart';
import 'package:roadsyouwalked_app/model/media/memory_day_mapper.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/calendar_control_bar.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/calendar_header.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/calendar_widget.dart';

class CalendarPage extends StatelessWidget {
  final Map<CalendarDay, List<Memory>> memoryMap;
  final VoidCallback onPrevPressed;
  final VoidCallback onNextPressed;

  CalendarPage(
    {
      super.key,
      required List<Memory> memories,
      required int year,
      required int month,
      required this.onPrevPressed,
      required this.onNextPressed,
    }
  ) : memoryMap = MemoryDayMapper.mapMemoriesToDays(
      CalendarTracker(month, year).getDaysCurrentMonthWithGap(),
      memories
    );

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CalendarControlBar(
          date: memoryMap.entries.firstWhere((entry) => entry.key.gapType == CalendarDayGapType.currentMonth).key.date,
          onPrevPressed: onPrevPressed,
          onNextPressed: onNextPressed,
        ),
        CalendarHeader(days: memoryMap.keys.toList()),
        CalendarWidget(memoryMap: memoryMap),
      ],
    );
  }
}
