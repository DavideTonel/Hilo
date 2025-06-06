import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/days/calendar_day_empty_widget.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/days/calendar_day_with_icon_widget.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/days/calendar_day_with_image_widget.dart';

class CalendarDayWidget extends StatelessWidget {
  final CalendarDay day;
  final List<Memory> memories;
  final double height;
  final double width;

  const CalendarDayWidget({
    super.key,
    required this.day,
    required this.memories,
    this.height = 90,
    this.width = 45,
  });

  @override
  Widget build(BuildContext context) {
    if (memories.any(
      (memory) =>
          memory.mediaList.any((media) => media.type == MediaType.image),
    )) {
      return CalendarDayWithImageWidget(
        day: day,
        memories: memories,
        height: height,
        width: width,
      );
    } else if (memories.any((memory) => memory.data.core.description != null)) {
      return CalendarDayWithEmojiWidget(
        day: day,
        memories: memories,
        emoji: "📝",
        height: height,
        width: width,
      );
    } else {
      return CalendarDayEmptyWidget(day: day, height: height, width: width);
    }
  }
}
