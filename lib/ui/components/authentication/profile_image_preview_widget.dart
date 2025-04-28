import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class ProfileImagePreviewWidget extends StatelessWidget {
  final String path;
  final VoidCallback onTap;

  const ProfileImagePreviewWidget({super.key, required this.path, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 170,
        height: 170,
        child: ClipOval(
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Image.file(File(path), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
