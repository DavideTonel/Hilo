import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

class YearEvaluationBarChartWidget extends StatelessWidget {
  final List<Memory> memories;
  final int year;

  const YearEvaluationBarChartWidget({
    super.key,
    required this.memories,
    required this.year,
  });

  Map<int, int> _countMemoriesPerMonth(List<Memory> memories, int year) {
    final Map<int, int> memoryCount = {for (var i = 1; i <= 12; i++) i: 0};
    for (final memory in memories) {
      final memoryMonth = DateTime.parse(memory.data.core.timestamp).month;
      memoryCount[memoryMonth] = memoryCount[memoryMonth]! + 1;
    }
    return memoryCount;
  }

  List<BarChartGroupData> _generateBarGroups(Map<int, int> monthlyCounts) {
    final sortedKeys = monthlyCounts.keys.toList()..sort();

    return List.generate(sortedKeys.length, (index) {
      final month = sortedKeys[index];
      final count = monthlyCounts[month]!;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(toY: count.toDouble(), color: Colors.blue, width: 16),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, int> dailyCounts = _countMemoriesPerMonth(memories, year);
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
