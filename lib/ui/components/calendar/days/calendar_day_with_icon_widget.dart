import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

class CalendarDayWithEmojiWidget extends StatelessWidget {
  final CalendarDay day;
  final List<Memory> memories;
  final String emoji;
  final double height;
  final double width;

  const CalendarDayWithEmojiWidget({
    super.key,
    required this.day,
    required this.memories,
    required this.emoji,
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Container(
              height: height,
              width: width,
              color:
                  day.gapType == CalendarDayGapType.currentMonth
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withAlpha(85),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                day.date.day.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:
                      day.gapType == CalendarDayGapType.currentMonth
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer.withAlpha(40),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(emoji),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
