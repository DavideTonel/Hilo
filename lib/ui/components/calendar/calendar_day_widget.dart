import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';

class CalendarDayWidget extends StatelessWidget {
  final String day;
  final CalendarDayGapType gapType;

  const CalendarDayWidget(
    {
      super.key,
      required this.day,
      required this.gapType
    }
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 90,
        width: 45,
        color: gapType.value == "GapCurrent" ? Colors.blue : Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(day),
          ],
        ),
      ),
    );
  }
}
