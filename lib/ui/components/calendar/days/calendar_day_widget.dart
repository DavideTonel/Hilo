import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/days/calendar_day_basic_widget.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/days/calendar_day_empty_widget.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/days/calendar_day_image_widget.dart';

class CalendarDayWidget extends StatelessWidget {
  final CalendarDay day;
  final List<Memory> memories;

  const CalendarDayWidget(
    {
      super.key,
      required this.day,
      required this.memories
    }
  );

  @override
  Widget build(BuildContext context) {
    if (memories.any((memory) => memory.mediaList.any((media) => media.type == MediaType.image))) { // TODO: create widget wrapper for media
      return CalendarDayImageWidget(day: day, memories: memories);
    } else if (memories.isNotEmpty) {
      return CalendarDayBasicWidget(day: day, memories: memories);
    } else {
      return CalendarDayEmptyWidget(day: day);
    }
  }
}
