import 'package:flutter/material.dart';

class CalendarWeekDayHeader extends StatelessWidget {
  final String weekDayName;
  const CalendarWeekDayHeader({super.key, required this.weekDayName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 45,
        width: 45,
        color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(weekDayName),
          ],
        )
      ),
    );
  }
}
