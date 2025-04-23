import 'package:flutter/material.dart';

class DateFooterWidget extends StatelessWidget {
  final String date;

  const DateFooterWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(date, style: TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }
}
