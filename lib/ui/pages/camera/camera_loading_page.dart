import 'package:flutter/material.dart';

class CameraLoadingPage extends StatelessWidget {
  const CameraLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
