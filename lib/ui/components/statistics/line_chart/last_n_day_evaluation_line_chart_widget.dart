import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class LastNDayEvaluationLineChartWidget extends StatelessWidget {
  final List<Memory> memories;
  final DateTime fromDate;
  final int lastNDays;

  const LastNDayEvaluationLineChartWidget({
    super.key,
    required this.memories,
    required this.fromDate,
    required this.lastNDays,
  });

  List<FlSpot> _getLastNMidnightForXAxisLabel({
    required final DateTime fromDate,
    required final int lastNDays,
  }) {
    // need to consider the midnight of the next day in order to consider the fromDate day
    final DateTime nextDay = fromDate.add(Duration(days: 1));
    final midnight = DateTime(nextDay.year, nextDay.month, nextDay.day);

    final List<DateTime> lastNMidnights = List.generate(lastNDays, (i) {
      return midnight.subtract(Duration(days: lastNDays - 1 - i));
    });

    return lastNMidnights.map((date) {
      final x = date.millisecondsSinceEpoch.toDouble();
      final y = 0.0;
      return FlSpot(x, y);
    }).toList();
  }

  Map<String, List<FlSpot>> _getSpotsGroupByLabel(final List<Memory> memories) {
    Map<String, List<FlSpot>> spotsGroupByLabel = {};
    if (memories.isNotEmpty) {
      for (final String label
          in memories.first.data.evaluation.evaluationResult.keys) {
        List<FlSpot> labeledSpots =
            memories
                .map(
                  (memory) => FlSpot(
                    DateTime.parse(
                      memory.data.core.timestamp,
                    ).millisecondsSinceEpoch.toDouble(),
                    memory.data.evaluation.evaluationResult[label]!,
                  ),
                )
                .toList();
        spotsGroupByLabel[label] = labeledSpots;
      }
    }
    return spotsGroupByLabel;
  }

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> lastNMidnights = _getLastNMidnightForXAxisLabel(
      fromDate: fromDate,
      lastNDays: lastNDays,
    );
    final Map<String, List<FlSpot>> spotsGroupByLabel = _getSpotsGroupByLabel(
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
                    minX: lastNMidnights.first.x,
                    maxX: lastNMidnights.last.x,
                    lineBarsData: [
                      LineChartBarData(
                        show: false,
                        spots: lastNMidnights,
                        dotData: FlDotData(show: true),
                      ),
                      ...spotsGroupByLabel.entries.map((entry) {
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
                          isStrokeCapRound: true,
                          dotData: FlDotData(show: false),
                          color: color,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                color.withAlpha(50),
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        );
                      }),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 28,
                          showTitles: true,
                          interval: Duration(days: 1).inMilliseconds.toDouble(),
                          getTitlesWidget: (value, meta) {
                            // Needed to avoid fl_chart bug wich creates two times the first label with an offset
                            if (DateTime.fromMillisecondsSinceEpoch(
                                  value.toInt(),
                                ).difference(
                                  DateTime.fromMillisecondsSinceEpoch(
                                    lastNMidnights.first.x.toInt(),
                                  ),
                                ) <
                                Duration(hours: 1)) {
                              return const SizedBox.shrink();
                            }
                            final label = DateFormat("d").format(
                              DateTime.fromMillisecondsSinceEpoch(
                                value.floor(),
                              ),
                            );
                            return Text(
                              label,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          reservedSize: 35,
                          showTitles: true,
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
                              return SizedBox.shrink();
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
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        )
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
