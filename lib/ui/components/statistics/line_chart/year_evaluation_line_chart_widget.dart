import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class YearEvaluationLineChartWidget extends StatelessWidget {
  final List<Memory> memories;

  const YearEvaluationLineChartWidget({super.key, required this.memories});

  Map<String, List<FlSpot>> _getSpotsGroupedByMonth(List<Memory> memories) {
    final Map<int, List<Memory>> groupedByMonth = {};

    for (final memory in memories) {
      final timestamp = DateTime.parse(memory.data.core.timestamp);
      final month = timestamp.month;
      groupedByMonth.putIfAbsent(month, () => []).add(memory);
    }

    final Set<String> allLabels = {
      for (final m in memories) ...m.data.evaluation.evaluationResult.keys,
    };

    final Map<String, List<FlSpot>> result = {
      for (final label in allLabels) label: [],
    };

    for (final entry in groupedByMonth.entries) {
      final month = entry.key;
      final memoriesOfMonth = entry.value;

      for (final label in allLabels) {
        final values =
            memoriesOfMonth
                .map((m) => m.data.evaluation.evaluationResult[label])
                .where((v) => v != null)
                .cast<double>()
                .toList();

        if (values.isNotEmpty) {
          final average = values.reduce((a, b) => a + b) / values.length;
          result[label]!.add(FlSpot(month.toDouble(), average));
        }
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<FlSpot>> spotsGroupByLabel = _getSpotsGroupedByMonth(
      memories,
    );

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
              "Mood Flow",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppSpacingConstants.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AspectRatio(
                aspectRatio: 1.7,
                child: LineChart(
                  LineChartData(
                    maxY: 25.8,
                    minY: 0,
                    minX: 1,
                    maxX: 12,
                    lineBarsData:
                        spotsGroupByLabel.entries.map((entry) {
                          final isPositive = entry.key == "positive";
                          final color =
                              isPositive
                                  ? const Color(0xFF8FD6B7)
                                  : const Color(0xFFEF9A9A);
                          return LineChartBarData(
                            spots: entry.value,
                            isCurved: true,
                            preventCurveOverShooting: true,
                            barWidth: 3,
                            dotData: FlDotData(show: false),
                            color: color,
                            isStrokeCapRound: true,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  color.withAlpha(50),
                                  Colors.transparent,
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          );
                        }).toList(),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 30,
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            if (value >= 1 && value <= 12) {
                              return Text(
                                value.floor().toString(),
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              );
                            }
                            return const Text('');
                          },
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
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(
                      border: Border(
                        left: BorderSide(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        bottom: BorderSide(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
