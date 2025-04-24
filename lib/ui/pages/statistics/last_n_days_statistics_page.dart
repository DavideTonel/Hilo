import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/statistics/line_chart/last_n_day_evaluation_line_chart_widget.dart';

class LastNDaysStatisticsPage extends StatelessWidget {
  final List<Memory> memories;
  final DateTime fromDate;
  final int lastNDays;

  const LastNDaysStatisticsPage({
    super.key,
    required this.memories,
    required this.fromDate,
    required this.lastNDays,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: LastNDayEvaluationLineChartWidget(
            memories: memories,
            fromDate: fromDate,
            lastNDays: lastNDays,
          ),
        ),
      ],
    );
  }
}
