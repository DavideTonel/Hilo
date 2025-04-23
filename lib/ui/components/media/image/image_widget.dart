import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageWidget extends StatefulWidget {
  final String imagePath;
  final double aspectRatio;

  const ImageWidget({
    super.key,
    required this.imagePath,
    this.aspectRatio = 0.8,
  });

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final image = FileImage(File(widget.imagePath));
    final completer = Completer<void>();

    final stream = image.resolve(const ImageConfiguration());
    final listener = ImageStreamListener((ImageInfo _, bool __) {
      completer.complete();
    }, onError: (error, stackTrace) {
      completer.complete();
    });

    stream.addListener(listener);
    await completer.future;
    stream.removeListener(listener);

    if (mounted) {
      setState(() => _isLoaded = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth / widget.aspectRatio;

    return SizedBox(
      width: screenWidth,
      height: imageHeight,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _isLoaded
            ? Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.cover,
                  width: screenWidth,
                  height: imageHeight,
                  key: const ValueKey('image'),
                ),
            )
            : Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: screenWidth,
                  height: imageHeight,
                  color: Colors.grey,
                  key: const ValueKey('shimmer'),
                ),
              ),
      ),
    );
  }
}
