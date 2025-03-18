import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/camera/camera_manager.dart';

class CameraPreviewWidget extends StatelessWidget {
  final CameraManager cameraManager;

  const CameraPreviewWidget({super.key, required this.cameraManager});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
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
                child: CameraPreview(cameraManager.getCameraController()!),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
