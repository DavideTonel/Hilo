import 'package:flutter/material.dart';

class AddProfileImageButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddProfileImageButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return IconButton(
      icon: Icon(
        Icons.add_a_photo,
        size: size.width * 0.2,
        color: Theme.of(context).colorScheme.primary,
      ),
      onPressed: onPressed,
    );
  }
}
