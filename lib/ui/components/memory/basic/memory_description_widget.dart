import 'package:flutter/material.dart';

class MemoryDescriptionWidget extends StatelessWidget {
  final String description;

  const MemoryDescriptionWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      softWrap: true,
    );
  }
}
