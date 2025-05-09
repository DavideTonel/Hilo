import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class YearEvaluationBarChartWidget extends StatelessWidget {
  final List<Memory> memories;

  const YearEvaluationBarChartWidget({super.key, required this.memories});

  Map<int, Map<String, double>> _groupAveragesByMonth(List<Memory> memories) {
    final Map<int, Map<String, List<double>>> grouped = {};

    for (final memory in memories) {
      final timestamp = DateTime.parse(memory.data.core.timestamp);
      final month = timestamp.month;

      final result = memory.data.evaluation.evaluationResult;
      if (!grouped.containsKey(month)) {
        grouped[month] = {};
      }

      result.forEach((label, value) {
        grouped[month]!.putIfAbsent(label, () => []).add(value);
      });
    }

    final Map<int, Map<String, double>> monthlyAverages = {};

    for (int month = 1; month <= 12; month++) {
      final labelMap = grouped[month];
      monthlyAverages[month] = {"positive": 0.0, "negative": 0.0};
      if (labelMap != null) {
        labelMap.forEach((label, values) {
          double avg = values.reduce((a, b) => a + b) / values.length;
          avg = double.parse(avg.toStringAsFixed(1));
          monthlyAverages[month]![label] = avg;
        });
      }
    }

    return monthlyAverages;
  }

  List<BarChartGroupData> _buildBars(
    Map<int, Map<String, double>> monthlyAverages,
  ) {
    final barGroups = <BarChartGroupData>[];

    for (int month = 1; month <= 12; month++) {
      final data = monthlyAverages[month];
      if (data != null) {
        final positive = data["positive"] ?? 0;
        final negative = data["negative"] ?? 0;

        barGroups.add(
          BarChartGroupData(
            x: month,
            barRods: [
              BarChartRodData(
                toY: positive,
                color: const Color(0xFF8FD6B7),
                width: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              BarChartRodData(
                toY: negative,
                color: const Color(0xFFEF9A9A),
                width: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
            barsSpace: 4,
          ),
        );
      }
    }

    return barGroups;
  }

  @override
  Widget build(BuildContext context) {
    final averagesByMonth = _groupAveragesByMonth(memories);
    final barGroups = _buildBars(averagesByMonth);

    final isDark = Theme.of(context).colorScheme.brightness == Brightness.dark;
    final Color color = isDark ? const Color(0xFF1A1A1A) : Theme.of(context).colorScheme.primary.withAlpha(20);

    return Card(
      elevation: isDark ? 4.0 : 0.0,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Mood Bars",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacingConstants.md),
            AspectRatio(
              aspectRatio: 1.7,
              child: BarChart(
                BarChartData(
                  maxY: 25.8,
                  minY: 0,
                  barGroups: barGroups,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value >= 1 && value <= 12) {
                            return Text(
                              value.floor().toString(),
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 28,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          if (value == 1) {
                            return Text(
                              "Low",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            );
                          } else if (value == 25) {
                            return Text(
                              "High",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      left: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  barTouchData: BarTouchData(enabled: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
