import 'package:flutter/material.dart';

class ImagePlaceholderWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const ImagePlaceholderWidget(
    {
      super.key,
      this.width,
      this.height
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.grey[300],
      child: const Icon(
        Icons.image,
        color: Colors.grey,
        size: 50,
      ),
    );
  }
}
