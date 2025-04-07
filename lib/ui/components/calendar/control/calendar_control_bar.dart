import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarControlBar extends StatelessWidget {
  final DateTime date;
  final VoidCallback onPrevPressed;
  final VoidCallback onNextPressed;

  const CalendarControlBar(
    {
      super.key,
      required this.date,
      required this.onPrevPressed,
      required this.onNextPressed
    }
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPrevPressed,
          icon: Icon(
            Icons.chevron_left
          )
        ),
        Text(
          DateFormat("MMM yyyy").format(date)
        ),
        IconButton(
          onPressed: onNextPressed,
          icon: Icon(
            Icons.chevron_right
          )
        ),
      ],
    );
  }
}
