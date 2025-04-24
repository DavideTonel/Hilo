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

  Map<int, int> _countMemoriesPerDay(
    List<Memory> memories,
    List<CalendarDay> daysInMonth,
  ) {
    final Map<int, int> countMap = {
      for (final day in daysInMonth) day.date.day: 0,
    };

    for (var memory in memories) {
      final dayKey = DateTime.parse(memory.data.core.timestamp).day;
      if (countMap.containsKey(dayKey)) {
        countMap[dayKey] = (countMap[dayKey] ?? 0) + 1;
      }
    }
    return countMap;
  }

  List<BarChartGroupData> _generateBarGroups(Map<int, int> dailyCounts) {
    final sortedKeys = dailyCounts.keys.toList()..sort();

    return List.generate(sortedKeys.length, (index) {
      final day = sortedKeys[index];
      final count = dailyCounts[day]!;

      return BarChartGroupData(
        x: day,
        barRods: [
          BarChartRodData(toY: count.toDouble(), color: Colors.blue, width: 12),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final dailyCounts = _countMemoriesPerDay(memories, daysInMonth);
    final barGroups = _generateBarGroups(dailyCounts);
    final chartWidth = daysInMonth.length * 20.0;
    final maxCount = (dailyCounts.values.isEmpty
            ? 1
            : dailyCounts.values.reduce((a, b) => a > b ? a : b)) +
        1;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Memories This Month", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: AppSpacingConstants.md),
            SizedBox(
              height: 250,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Asse Y allineato tramite BarChart "dummy"
                  SizedBox(
                    width: 50,
                    child: BarChart(
                      BarChartData(
                        maxY: maxCount.toDouble(),
                        minY: 0,
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return SizedBox(
                                  height: 250 / maxCount,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Text(
                                        value.toInt().toString(),
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        gridData: FlGridData(show: true, drawVerticalLine: false),
                        barGroups: [], // Nessuna barra
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Grafico scrollabile con barre
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: chartWidth,
                        child: BarChart(
                          BarChartData(
                            maxY: maxCount.toDouble(),
                            minY: 0,
                            barGroups: barGroups,
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  reservedSize: 28,
                                  getTitlesWidget: (value, meta) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        value.toInt().toString(),
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            gridData: FlGridData(show: true, drawVerticalLine: false),
                            borderData: FlBorderData(
                              border: const Border(
                                bottom: BorderSide(),
                                left: BorderSide(), // opzionale
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
