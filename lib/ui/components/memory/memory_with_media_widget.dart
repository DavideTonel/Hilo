import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/footer/date_footer_widget.dart';
import 'package:roadsyouwalked_app/ui/components/media/image/image_widget.dart';
import 'package:roadsyouwalked_app/ui/components/memory/basic/memory_description_widget.dart';
import 'package:roadsyouwalked_app/ui/components/memory/basic/memory_header_widget.dart';
import 'package:roadsyouwalked_app/ui/components/memory/basic/memory_map_widget.dart';

class MemoryWithMediaWidget extends StatefulWidget {
  final Memory memory;
  final double aspectRatio;

  const MemoryWithMediaWidget({
    super.key,
    required this.memory,
    this.aspectRatio = 0.8,
  });

  @override
  State<MemoryWithMediaWidget> createState() => _MemoryWithMediaWidgetState();
}

class _MemoryWithMediaWidgetState extends State<MemoryWithMediaWidget> {
  bool _showMap = false;
  late final String? imagePath;
  late final DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.parse(widget.memory.data.core.timestamp);
    imagePath =
        widget.memory.mediaList
            .firstWhere(
              (media) => media.type == MediaType.image,
              orElse: () => throw Exception("No image media found"),
            )
            .reference;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth / widget.aspectRatio;

    final hasMap = widget.memory.data.position != null;

    return Material(
      elevation: 0,
      type: MaterialType.card,
      color: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MemoryHeaderWidget(iconData: Icons.image, dateTime: dateTime),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() => _showMap = !_showMap);
            },
            child: SizedBox(
              width: screenWidth,
              height: imageHeight,
              child:
                  hasMap && _showMap
                      ? Container(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: screenWidth,
                          height: imageHeight,
                          child: Stack(
                            children: [
                              MemoryMapWidget(
                                width: screenWidth,
                                height: imageHeight,
                                position: widget.memory.data.position!,
                                dateTime: dateTime,
                                zoom: 17.2,
                                pitch: 50.0,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  setState(() => _showMap = false);
                                },
                                child: Container(
                                  width: screenWidth,
                                  height: imageHeight,
                                  color: Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      : Stack(
                        children: [
                          ImageWidget(imagePath: imagePath!),
                          if (hasMap)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 4,
                                ),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.map,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "Map",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              top: 4.0,
              bottom: 0.0,
            ),
            child: Column(
              children: [
                if (widget.memory.data.core.description != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: MemoryDescriptionWidget(
                          description: widget.memory.data.core.description!,
                        ),
                      ),
                    ],
                  ),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [DateFooterWidget(dateTime: dateTime)],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
