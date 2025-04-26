import 'package:flutter/material.dart';

class CalendarWeekDayHeader extends StatelessWidget {
  final String weekDayName;
  final double height;
  final double width;

  const CalendarWeekDayHeader({
    super.key,
    required this.weekDayName,
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
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12), // Arrotonda i bordi
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(weekDayName)],
        ),
      ),
    );
  }
}
