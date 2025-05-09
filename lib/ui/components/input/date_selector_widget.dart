import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectorWidget extends StatelessWidget {
  final String label;
  final DateTime? value;
  final Function(DateTime date) onDateSelected;

  const DateSelectorWidget({super.key, required this.label, this.value, required this.onDateSelected});

  Future<void> _selectBirthday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectBirthday(context),
      child: AbsorbPointer(
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: value == null
                ? label
                : DateFormat("dd/MM/yyyy").format(value!),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          readOnly: true,
        ),
      ),
    );
  }
}
