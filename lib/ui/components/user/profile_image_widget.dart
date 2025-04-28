import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  final String path;
  final double width;

  const ProfileImageWidget({super.key, required this.path, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width,
      child: ClipOval(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: Image.file(File(path), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
