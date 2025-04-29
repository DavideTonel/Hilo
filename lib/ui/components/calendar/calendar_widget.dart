import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:roadsyouwalked_app/bloc/memory/memories_detail_bloc/memories_detail_bloc.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/days/calendar_day_widget.dart';

class CalendarWidget extends StatelessWidget {
  final Map<CalendarDay, List<Memory>> memoryMap;
  final double itemHeight;
  final double itemWidth;

  const CalendarWidget(
    {
      super.key,
      required this.memoryMap,
      this.itemHeight = 90,
      this.itemWidth = 45
    }
  );

  @override
  Widget build(BuildContext context) {
    final entries = memoryMap.entries.toList();
    List<List<InkWell>> calendarRows = List.generate(
      (memoryMap.length / 7).floor(),
      (_) => []
    );

    for (int i = 0; i < memoryMap.length; i++) {
      final indexRow = i ~/ 7;

      calendarRows[indexRow].add(
        InkWell(
          onTap: () {
            if (entries[i].value.isNotEmpty) {
              context.read<MemoriesDetailBloc>().add(
                SetMemoriesDetail(
                  memories: entries[i].value
                )
              );
              GoRouter.of(context).push("/calendar/memories");
            }
          },
          child: CalendarDayWidget(
            day: entries[i].key,
            memories: entries[i].value,
            height: itemHeight,
            width: itemWidth,
          ),
        )
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: calendarRows.map((calendaRow) => Row(mainAxisAlignment: MainAxisAlignment.center, children: calendaRow,)).toList(),
    );
  }
}
