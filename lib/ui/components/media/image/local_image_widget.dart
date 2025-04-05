import 'dart:io';

import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/ui/components/media/image/image_error_widget.dart';
import 'package:roadsyouwalked_app/ui/components/media/image/image_placeholder_widget.dart';
import 'package:roadsyouwalked_app/ui/components/media/image/image_widget.dart';

class LocalImageWidget extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;

  const LocalImageWidget(
    {
      super.key,
      required this.path,
      this.width,
      this.height
    }
  );

  @override
  Widget build(BuildContext context) {
    final file = File(path);

    return FutureBuilder<bool>(
      future: file.exists(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ImagePlaceholderWidget(
            width: width,
            height: height
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return ImageWidget(
            file: file,
            width: width,
            height: height,
          );
        } else if (snapshot.hasData && snapshot.data == false) {
          return ImageErrorWidget(
            width: width,
            height: height
          );
        } else {
          return ImageErrorWidget(
            width: width,
            height: height
          );
        }
      }
    );
  }
}
