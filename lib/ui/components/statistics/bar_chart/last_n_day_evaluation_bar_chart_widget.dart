import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class LastNDayEvaluationBarChartWidget extends StatelessWidget {
  final List<Memory> memories;
  final DateTime fromDate;
  final int lastNDays;

  const LastNDayEvaluationBarChartWidget({
    super.key,
    required this.memories,
    required this.fromDate,
    required this.lastNDays,
  });

  List<DateTime> _getLastNMidnights({
    required DateTime fromDate,
    required int lastNDays,
  }) {
    final nextDay = fromDate.add(const Duration(days: 1));
    final midnight = DateTime(nextDay.year, nextDay.month, nextDay.day);

    return List.generate(lastNDays, (i) {
      return midnight.subtract(Duration(days: lastNDays - 1 - i));
    });
  }

  Map<String, Map<DateTime, double>> _getBarValuesGrouped(
    List<Memory> memories,
    List<DateTime> midnights,
  ) {
    Map<String, Map<DateTime, double>> groupedData = {
      'positive': {},
      'negative': {},
    };

    for (var midnight in midnights) {
      final dayStart = midnight;
      final dayEnd = midnight.add(const Duration(days: 1));

      final dailyMemories = memories.where((m) {
        final ts = DateTime.parse(m.data.core.timestamp);
        return ts.isAfter(dayStart.subtract(const Duration(seconds: 1))) &&
            ts.isBefore(dayEnd);
      });

      for (var label in groupedData.keys) {
        final avg = dailyMemories
            .map((m) => m.data.evaluation.evaluationResult[label])
            .whereType<double>()
            .fold<double>(0.0, (sum, val) => sum + val) /
            (dailyMemories.isNotEmpty ? dailyMemories.length : 1);

        groupedData[label]![midnight] = avg.isNaN ? 0 : avg;
      }
    }

    return groupedData;
  }

  @override
  Widget build(BuildContext context) {
    final midnights = _getLastNMidnights(fromDate: fromDate, lastNDays: lastNDays);
    final grouped = _getBarValuesGrouped(memories, midnights);

    final isDark = Theme.of(context).colorScheme.brightness == Brightness.dark;
    final Color color = isDark ? const Color(0xFF1A1A1A) : Theme.of(context).colorScheme.primary.withAlpha(20);

    return Card(
      elevation: isDark ? 4.0 : 0.0,
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                  barGroups: List.generate(midnights.length, (index) {
                    final x = index.toDouble();
                    final date = midnights[index];
                    return BarChartGroupData(
                      x: x.toInt(),
                      barRods: [
                        BarChartRodData(
                          toY: grouped['positive']?[date] ?? 0,
                          color: const Color(0xFF8FD6B7),
                          width: 8,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        BarChartRodData(
                          toY: grouped['negative']?[date] ?? 0,
                          color: const Color(0xFFEF9A9A),
                          width: 8,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ],
                      barsSpace: 4,
                    );
                  }),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= midnights.length) return const SizedBox.shrink();
                          final label = DateFormat('dd').format(midnights[index]);
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
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(
                    border: Border(
                      left: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      bottom: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: false),
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
