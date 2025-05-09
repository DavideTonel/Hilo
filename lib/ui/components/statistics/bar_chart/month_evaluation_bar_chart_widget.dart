import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class MonthEvaluationBarChartWidget extends StatelessWidget {
  final List<Memory> memories;
  final List<CalendarDay> daysInMonth;

  const MonthEvaluationBarChartWidget({
    super.key,
    required this.memories,
    required this.daysInMonth,
  });

  Map<int, Map<String, double>> _getAveragedValuesByDay(List<Memory> memories) {
    final Map<int, Map<String, List<double>>> tempGrouped = {};

    for (final memory in memories) {
      final timestamp = DateTime.parse(memory.data.core.timestamp);
      final day = timestamp.day;

      for (final entry in memory.data.evaluation.evaluationResult.entries) {
        final label = entry.key;
        final value = entry.value;

        tempGrouped.putIfAbsent(day, () => {});
        tempGrouped[day]!.putIfAbsent(label, () => []);
        tempGrouped[day]![label]!.add(value);
      }
    }

    final Map<int, Map<String, double>> result = {};
    for (final dayEntry in tempGrouped.entries) {
      final Map<String, double> labelAverages = {};
      for (final labelEntry in dayEntry.value.entries) {
        final values = labelEntry.value;
        final average = values.reduce((a, b) => a + b) / values.length;
        labelAverages[labelEntry.key] = average;
      }
      result[dayEntry.key] = labelAverages;
    }

    return result;
  }

  List<BarChartGroupData> _getBarGroups(
    Map<int, Map<String, double>> dataByDay,
  ) {
    final List<BarChartGroupData> barGroups = [];

    for (final day in daysInMonth.map((e) => e.date.day)) {
      final labelValues = dataByDay[day] ?? {};
      final isPositive = labelValues.containsKey("positive");
      final isNegative = labelValues.containsKey("negative");

      final List<BarChartRodData> rods = [];

      if (isPositive) {
        rods.add(
          BarChartRodData(
            toY: labelValues["positive"]!,
            color: const Color(0xFF8FD6B7),
            width: 6,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }

      if (isNegative) {
        rods.add(
          BarChartRodData(
            toY: labelValues["negative"]!,
            color: const Color(0xFFEF9A9A),
            width: 6,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }

      barGroups.add(BarChartGroupData(x: day, barRods: rods, barsSpace: 4));
    }

    return barGroups;
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, Map<String, double>> averagedData = _getAveragedValuesByDay(
      memories,
    );
    final List<BarChartGroupData> barGroups = _getBarGroups(averagedData);
    final double chartWidth = daysInMonth.length * 23.0;

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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "High",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "Low",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: chartWidth,
                        child: BarChart(
                          BarChartData(
                            maxY: 25.8,
                            minY: 0,
                            barGroups: barGroups,
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 28,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(
                              border: Border(
                                left: BorderSide(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                ),
                                bottom: BorderSide(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.onPrimaryContainer,
                                ),
                              ),
                            ),
                            barTouchData: BarTouchData(enabled: false),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
