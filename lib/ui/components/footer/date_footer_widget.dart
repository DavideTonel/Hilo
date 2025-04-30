import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFooterWidget extends StatelessWidget {
  final DateTime dateTime;
  final Color? color;

  const DateFooterWidget({super.key, required this.dateTime, this.color});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat("dd/MM/yyyy   HH:mm",).format(dateTime);
    return Row(
      children: [
        Text(
          date,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(175)
          )
        ),
      ],
    );
  }
}
