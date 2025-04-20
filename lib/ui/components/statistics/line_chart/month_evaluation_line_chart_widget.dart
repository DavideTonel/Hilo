import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

class MonthEvaluationLineChartWidget extends StatelessWidget {
  final List<Memory> memories;
  final List<CalendarDay> daysInMonth;

  const MonthEvaluationLineChartWidget({
    super.key,
    required this.memories,
    required this.daysInMonth,
  });

  List<FlSpot> _getDaysForXAxis(final List<CalendarDay> daysInMonth) {
    return daysInMonth
        .map((day) => FlSpot(day.date.day.toDouble(), 0))
        .toList();
  }

  Map<String, List<FlSpot>> _getSpotsGroupByLabel(final List<Memory> memories) {
    final Map<DateTime, List<Memory>> groupedByDay = {};

    for (final memory in memories) {
      final timestamp = DateTime.parse(memory.data.core.timestamp);
      final date = DateTime(
        timestamp.year,
        timestamp.month,
        timestamp.day,
      );
      groupedByDay.putIfAbsent(date, () => []).add(memory);
    }
    final Set<String> allLabels = {
      for (final m in memories) ...m.data.evaluation.evaluationResult.keys,
    };
    final Map<String, List<FlSpot>> result = {
      for (final label in allLabels) label: [],
    };
    for (final entry in groupedByDay.entries) {
      final day = entry.key;
      final memoriesOfDay = entry.value;
      for (final label in allLabels) {
        final values =
            memoriesOfDay
                .map((m) => m.data.evaluation.evaluationResult[label])
                .where((v) => v != null)
                .cast<double>()
                .toList();

        if (values.isNotEmpty) {
          final average = values.reduce((a, b) => a + b) / values.length;
          final x = day.day.toDouble();
          final y = average;
          result[label]!.add(FlSpot(x, y));
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> spotsDaysInMonth = _getDaysForXAxis(daysInMonth);
    Map<String, List<FlSpot>> spotsGroupByLabel = _getSpotsGroupByLabel(
      memories,
    );

    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          maxY: 25,
          minY: 0,
          minX: spotsDaysInMonth.first.x,
          maxX: spotsDaysInMonth.last.x,
          lineBarsData: [
            LineChartBarData(
              show: false,
              spots: spotsDaysInMonth,
              dotData: FlDotData(show: true),
            ),
      
            ...spotsGroupByLabel.entries.map((entry) {
              return LineChartBarData(
                spots: entry.value,
                isCurved: true,
                preventCurveOverShooting: true,
                dotData: FlDotData(show: true),
                color: entry.key == "positive" ? Colors.green : Colors.red,
                barWidth: 1,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      entry.key == "positive" ? Colors.green : Colors.red,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              );
            }),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 7,
                getTitlesWidget: (value, meta) {
                  return Text(value.toInt().toString(), style: const TextStyle(fontSize: 12));
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  if (value == 1) {
                    return Text("Low", style: const TextStyle(fontSize: 12));
                  } else if (value == 25) {
                    return Text("High", style: const TextStyle(fontSize: 12));
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(
            border: Border(left: BorderSide(), bottom: BorderSide()),
          ),
        ),
      ),
    );
  }
}
