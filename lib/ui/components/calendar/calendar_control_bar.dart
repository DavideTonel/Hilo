import 'package:flutter/material.dart';

class CalendarControlBar extends StatelessWidget {
  const CalendarControlBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.chevron_left
          )
        ),
        Text(
          "March, 2025"
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.chevron_right
          )
        ),
      ],
    );
  }
}
