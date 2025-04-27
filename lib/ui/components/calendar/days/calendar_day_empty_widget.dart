import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';

class CalendarDayEmptyWidget extends StatelessWidget {
  final CalendarDay day;
  final double height;
  final double width;

  const CalendarDayEmptyWidget({
    super.key,
    required this.day,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color:
              day.gapType == CalendarDayGapType.currentMonth
                  ? Theme.of(context).colorScheme.primaryContainer.withAlpha(150)
                  : Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withAlpha(85),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              day.date.day.toString(),
              style: TextStyle(
                color:
                    day.gapType == CalendarDayGapType.currentMonth
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(
                          context,
                        ).colorScheme.onPrimaryContainer.withAlpha(80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
