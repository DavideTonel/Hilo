import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class CameraMediaPage extends StatelessWidget {
  final File media;
  
  const CameraMediaPage({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: 100,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Image.file(media),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
