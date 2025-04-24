import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';

class CameraMediaPreviewPage extends StatelessWidget {
  final File media;
  final void Function(File? localFile, String? remoteUri, MediaType mediaType) onSaveMedia;
  
  const CameraMediaPreviewPage({super.key, required this.media, required this.onSaveMedia});

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: IconButton(
          onPressed: () {
            return onSaveMedia(media, null, MediaType.image);
          },
          icon: Icon(Icons.check_box,size: 80,)
        ),
      ),
    );
  }
}
