import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/camera/camera_manager.dart';
import 'package:roadsyouwalked_app/ui/components/camera/camera_button.dart';
import 'package:roadsyouwalked_app/ui/components/camera/camera_preview_widget.dart';

class CameraPreviewPage extends StatelessWidget {
  final VoidCallback onCameraTap;
  final CameraManager cameraManager;

  const CameraPreviewPage({super.key, required this.cameraManager, required this.onCameraTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CameraPreviewWidget(cameraManager: cameraManager),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: CameraButton(onPressed: onCameraTap),
      ),
    );
  }
}
