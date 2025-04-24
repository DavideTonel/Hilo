import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_tracker.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/components/statistics/bar_chart/month_evaluation_bar_chart_widget.dart';
import 'package:roadsyouwalked_app/ui/components/statistics/line_chart/month_evaluation_line_chart_widget.dart';
import 'package:roadsyouwalked_app/ui/components/controller/period_controller_widget.dart';

class MonthStatisticsPage extends StatelessWidget {
  final List<Memory> memories;
  final int month;
  final int year;
  final VoidCallback onPreviousPressed;
  final VoidCallback onNextPressed;
  late final List<CalendarDay> daysInMonth;

  MonthStatisticsPage({
    super.key,
    required this.memories,
    required this.month,
    required this.year,
    required this.onPreviousPressed,
    required this.onNextPressed
  }) : daysInMonth = CalendarTracker(month, year).getDaysCurrentMonth();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          PeriodControllerWidget(
            header: DateFormat("MMM yyyy").format(DateTime(year, month)),
            onPreviousPressed: onPreviousPressed,
            onNextPressed: onNextPressed,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: MonthEvaluationLineChartWidget(
              memories: memories,
              daysInMonth: daysInMonth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: MonthEvaluationBarChartWidget(
              memories: memories,
              daysInMonth: daysInMonth,
            ),
          ),
        ],
      ),
    );
  }
}
