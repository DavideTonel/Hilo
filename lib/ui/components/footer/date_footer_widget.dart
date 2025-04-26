import 'package:flutter/material.dart';

class DateFooterWidget extends StatelessWidget {
  final String date;
  final Color? color;

  const DateFooterWidget({super.key, required this.date, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(date, style: TextStyle(fontSize: 10, color: color ?? Colors.black54)),
      ],
    );
  }
}
