import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MemoryHeaderWidget extends StatelessWidget {
  final IconData iconData;
  final DateTime dateTime;

  const MemoryHeaderWidget({
    super.key,
    required this.iconData,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM').format(dateTime);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(iconData, size: 24, weight: FontWeight.w500.value.toDouble()),
        SizedBox(width: 8),
        Text(
          date,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16
          )
        ),
      ],
    );
  }
}
