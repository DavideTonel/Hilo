import 'package:flutter/material.dart';

class ImageErrorWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const ImageErrorWidget(
    {
      super.key,
      this.width,
      this.height
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: const Icon(
        Icons.error,
        color: Colors.red,
        size: 50,
      ),
    );
  }
}
