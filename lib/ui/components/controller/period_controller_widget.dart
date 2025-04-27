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
        Card(
          elevation: 2.0,
          color: Theme.of(context).colorScheme.surfaceContainer,
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
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
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
