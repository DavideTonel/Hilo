import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class CameraMediaPreviewPage extends StatelessWidget {
  final File media;
  final void Function(File? localFile, String? remoteUri, MediaType mediaType) onSaveMedia;
  final VoidCallback onDiscardMedia;
  
  const CameraMediaPreviewPage({super.key, required this.media, required this.onSaveMedia, required this.onDiscardMedia});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
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
      bottomNavigationBar: BottomAppBar(
        height: 200,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onDiscardMedia,
              icon: Icon(Icons.close, size: 80,)
            ),
            SizedBox(width: AppSpacingConstants.xl),
            IconButton(
              onPressed: () {
                return onSaveMedia(media, null, MediaType.image);
              },
              icon: Icon(Icons.check, size: 80,)
            ),
          ],
        ),
      ),
    );
  }
}
