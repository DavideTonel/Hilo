import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/media/image/image_widget.dart';
import 'dart:developer' as dev;

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
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Colors.black12,
                BlendMode.darken,
              ),
              child: ImageWidget(
                imagePath:
                    memories
                        .where((memory) => memory.mediaList.isNotEmpty)
                        .map((memory) => memory.mediaList)
                        .lastWhere((medias) => medias.any((media) => media.type == MediaType.image))
                        .lastWhere((media) => media.type == MediaType.image)
                        .reference,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                day.date.day.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            /*
            Align(    // I don't know if I like it
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  "${memories.length - 1 > 0 ? "+${memories.length - 1}" : null}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}
