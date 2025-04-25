import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

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
        final values = memoriesOfDay
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
    Map<String, List<FlSpot>> spotsGroupByLabel = _getSpotsGroupByLabel(memories);

    final double chartWidth = daysInMonth.length * 23.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Mood Flow"),
            const SizedBox(height: AppSpacingConstants.md),
            SizedBox(
              height: 250,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("High", style: TextStyle(fontSize: 12)),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: Text("Low", style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: chartWidth,
                        child: LineChart(
                          LineChartData(
                            maxY: 25.8,
                            minY: 0,
                            minX: spotsDaysInMonth.first.x,
                            maxX: spotsDaysInMonth.last.x + 1,
                            lineBarsData: [
                              LineChartBarData(
                                show: false,
                                spots: spotsDaysInMonth,
                                dotData: FlDotData(show: true),
                              ),
                              ...spotsGroupByLabel.entries.map((entry) {
                                final isPositive = entry.key == "positive";
                                final color = isPositive
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
                              }),
                            ],
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  reservedSize: 28,
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value <= spotsDaysInMonth.last.x
                                          ? value.toInt().toString()
                                          : "",
                                      style: const TextStyle(fontSize: 12),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles:
                                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles:
                                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(
                              border: const Border(
                                left: BorderSide(),
                                bottom: BorderSide(),
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
          ],
        ),
      ),
    );
  }
}
