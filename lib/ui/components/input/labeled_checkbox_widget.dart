import 'package:flutter/material.dart';

class LabeledCheckboxWidget extends StatelessWidget {
  final String label;
  final bool value;
  final void Function(bool? value) onChanged;

  const LabeledCheckboxWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
