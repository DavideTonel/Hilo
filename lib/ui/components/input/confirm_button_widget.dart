import 'package:flutter/material.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  const ConfirmButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
