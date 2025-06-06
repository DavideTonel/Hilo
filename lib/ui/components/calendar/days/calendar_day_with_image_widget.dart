import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/media/image/image_widget.dart';

class CalendarDayWithImageWidget extends StatelessWidget {
  final CalendarDay day;
  final List<Memory> memories;
  final double height;
  final double width;

  const CalendarDayWithImageWidget({
    super.key,
    required this.day,
    required this.memories,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            ImageWidget(
              imagePath:
                  memories
                      .where((memory) => memory.mediaList.isNotEmpty)
                      .map((memory) => memory.mediaList)
                      .lastWhere(
                        (medias) => medias.any(
                          (media) => media.type == MediaType.image,
                        ),
                      )
                      .lastWhere((media) => media.type == MediaType.image)
                      .reference,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                day.date.day.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.black.withAlpha(150),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
