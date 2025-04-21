import 'package:flutter/material.dart';

class PeriodControllerWidget extends StatelessWidget {
  final String header;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;

  const PeriodControllerWidget({
    super.key,
    required this.header,
    required this.onPreviousPressed,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPreviousPressed,
          icon: Icon(Icons.chevron_left),
        ),
        Text(header),
        IconButton(onPressed: onNextPressed, icon: Icon(Icons.chevron_right)),
      ],
    );
  }
}
