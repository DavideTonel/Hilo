import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/statistics/bar_chart/year_evaluation_bar_chart_widget.dart';
import 'package:roadsyouwalked_app/ui/components/statistics/line_chart/year_evaluation_line_chart_widget.dart';
import 'package:roadsyouwalked_app/ui/components/controller/period_controller_widget.dart';

class YearStatisticsPage extends StatelessWidget {
  final List<Memory> memories;
  final int year;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;

  const YearStatisticsPage({
    super.key,
    required this.memories,
    required this.year,
    required this.onPreviousPressed,
    required this.onNextPressed
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PeriodControllerWidget(
          header: year.toString(),
          onPreviousPressed: onPreviousPressed,
          onNextPressed: onNextPressed,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: YearEvaluationLineChartWidget(memories: memories, year: year),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: YearEvaluationBarChartWidget(memories: memories, year: year),
        ),
      ],
    );
  }
}
