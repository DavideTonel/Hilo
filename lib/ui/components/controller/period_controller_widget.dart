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
    final isDark = Theme.of(context).colorScheme.brightness == Brightness.dark;
    final Color color = isDark ? const Color(0xFF1A1A1A) : Theme.of(context).colorScheme.primary.withAlpha(20);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          elevation: isDark ? 2.0 : 0.0,
          color: color,
          child: Row(
            children: [
              IconButton(
                onPressed: onPreviousPressed,
                icon: Icon(Icons.chevron_left, size: 28),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  header,
                  style: TextStyle(
                    fontSize: 18,
                  )
                ),
              ),
              IconButton(
                onPressed: onNextPressed,
                icon: Icon(Icons.chevron_right, size: 28),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
