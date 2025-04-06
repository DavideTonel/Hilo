import 'package:flutter/material.dart';

class CameraDeniedPage extends StatelessWidget {
  final VoidCallback onChangePermissionsPressed;

  const CameraDeniedPage({super.key, required this.onChangePermissionsPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Camera permissions are required to take photo and videos"),
          MaterialButton(
            onPressed: onChangePermissionsPressed,
            child: Text("Change permissions")
          )
        ],
      ),
    );
  }
}
