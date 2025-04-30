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
                  ? Theme.of(context).colorScheme.primary.withAlpha(90)
                  : Theme.of(
                    context,
                  ).colorScheme.primary.withAlpha(55),
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
                        ? Theme.of(context).colorScheme.onSurface
                        : Theme.of(
                          context,
                        ).colorScheme.onSurface.withAlpha(80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
