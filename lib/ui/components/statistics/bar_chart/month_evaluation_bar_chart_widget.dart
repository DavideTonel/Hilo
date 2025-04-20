import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

class MonthEvaluationBarChartWidget extends StatelessWidget {
  final List<Memory> memories;
  final List<CalendarDay> daysInMonth;

  const MonthEvaluationBarChartWidget({
    super.key,
    required this.memories,
    required this.daysInMonth,
  });

  Map<int, int> _countMemoriesPerDay(
    List<Memory> memories,
    List<CalendarDay> daysInMonth,
  ) {
    final Map<int, int> countMap = {};

    for (final day in daysInMonth) {
      countMap[day.date.day] = 0;
    }

    for (var memory in memories) {
      final dayKey = DateTime.parse(memory.data.core.timestamp).day;
      countMap[dayKey] = (countMap[dayKey] ?? 0) + 1;
    }
    return countMap; //..removeWhere((key, value) => value == 0);
  }

  List<BarChartGroupData> _generateBarGroups(Map<int, int> dailyCounts) {
    final sortedKeys = dailyCounts.keys.toList()..sort();

    return List.generate(sortedKeys.length, (index) {
      final day = sortedKeys[index];
      final count = dailyCounts[day]!;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(toY: count.toDouble(), color: Colors.blue, width: 16),
        ],
        //showingTooltipIndicators: [0],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, int> dailyCounts = _countMemoriesPerDay(
      memories,
      daysInMonth,
    );
    final List<BarChartGroupData> barGroups = _generateBarGroups(dailyCounts);

    return AspectRatio(
      aspectRatio: 1.7,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            barGroups: barGroups,
            borderData: FlBorderData(
              border: Border(left: BorderSide(), bottom: BorderSide()),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  interval: 1,
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt() + 1;
                    return Text("$index", style: const TextStyle(fontSize: 10));
                  },
                  interval: 1,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(show: false),
            maxY:
                (dailyCounts.values.fold(
                  0,
                  (max, e) => e > max ? e : max,
                )).toDouble() +
                1,
          ),
        ),
      ),
    );
  }
}
