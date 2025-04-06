import 'package:flutter/material.dart';

class NewMemoryTextPage extends StatelessWidget {
  final void Function(String description) onChangeDescription;
  const NewMemoryTextPage({super.key, required this.onChangeDescription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            maxLines: 8,
            onChanged: (value) {
              onChangeDescription(value);
            },
            decoration: InputDecoration(
              labelText: 'How are you feeling?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            ),
          ),
        ],
      ),
    );
  }
}
