import 'dart:io';

import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/ui/pages/camera/camera_page.dart';
import 'package:roadsyouwalked_app/ui/pages/memory/new_memory/new_memory_text_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewMemoryInputPage extends StatefulWidget {
  final void Function(File? localFile, String? remoteUri, MediaType mediaType) onSaveMedia;
  final void Function(String description) onChangeDescription;

  const NewMemoryInputPage({
    super.key,
    required this.onSaveMedia,
    required this.onChangeDescription,
  });

  @override
  NewMemoryInputPageState createState() => NewMemoryInputPageState();
}

class NewMemoryInputPageState extends State<NewMemoryInputPage> {
  final PageController _horizontalController = PageController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _horizontalController,
          scrollDirection: Axis.horizontal,
          children: [
            CameraPage(
              key: const PageStorageKey("camera"),
              onSaveMedia: widget.onSaveMedia,
            ),
            NewMemoryTextPage(
              onChangeDescription: widget.onChangeDescription,
            ),
          ],
        ),
        Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: Center(
            child: SmoothPageIndicator(
              controller: _horizontalController,
              count: 3,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                spacing: 12,
                activeDotColor: Theme.of(context).colorScheme.primary,
                dotColor: Colors.black.withAlpha(100),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
