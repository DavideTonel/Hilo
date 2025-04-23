import 'package:flutter/material.dart';

class LikeButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const LikeButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: Icon(Icons.favorite));
  }
}
