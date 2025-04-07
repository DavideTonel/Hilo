import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget { // TODO: implement if source is network
  final File file;
  final double? width;
  final double? height;
  final FilterQuality? filterQuality;

  const ImageWidget(
    {
      super.key,
      required this.file,
      this.width,
      this.height,
      this.filterQuality = FilterQuality.high
    }
  );
  
  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Image.file(
        file,
        width: width,
        height: height,
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
