import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

class YearEvaluationLineChartWidget extends StatelessWidget {
  final List<Memory> memories;
  final int year;

  const YearEvaluationLineChartWidget({
    super.key,
    required this.memories,
    required this.year,
  });

  List<FlSpot> _getMonthForXAxis() {
    return List.generate(12, (i) => i + 1).map((elem) => FlSpot(elem.toDouble(), 0.0)).toList();
  }

  Map<String, List<FlSpot>> _getSpotsGroupByLabel(final List<Memory> memories) {
    final Map<DateTime, List<Memory>> groupedByDay = {};

    for (final memory in memories) {
      final timestamp = DateTime.parse(memory.data.core.timestamp);
      final date = DateTime(
        timestamp.year,
        timestamp.month,
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
          final average = values.reduce((a, b) => a + b) / values.length; // TODO: decimals
          final x = day.month.toDouble();
          final y = average;
          result[label]!.add(FlSpot(x, y));
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> monthsInYear = _getMonthForXAxis();
    Map<String, List<FlSpot>> spotsGroupByLabel = _getSpotsGroupByLabel(
      memories,
    );

    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          maxY: 25,
          minY: 0,
          minX: monthsInYear.first.x,
          maxX: monthsInYear.last.x,
          lineBarsData: [
            LineChartBarData(
              show: false,
              spots: monthsInYear,
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
                interval: 1,
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
