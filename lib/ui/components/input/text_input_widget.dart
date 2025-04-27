import 'package:flutter/material.dart';

// TODO: make button for secret text field with visible and not visible text value
class TextInputWidget extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final bool obscureText;
  final void Function(String value)? onChanged;
  final bool isValid;
  final String? errorText;

  const TextInputWidget({
    super.key,
    required this.textController,
    required this.labelText,
    this.obscureText = false,
    this.onChanged,
    this.isValid = true,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 12,
      ),
      controller: textController,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        errorText: isValid ? null : errorText,
      ),
      textInputAction: TextInputAction.next,
    );
  }
}
