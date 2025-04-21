import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

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

    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          maxY: 25,
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
                  final label = DateFormat(
                    'dd MMM',
                  ).format(DateTime.fromMillisecondsSinceEpoch(value.floor()));
                  return Text(label, style: const TextStyle(fontSize: 12));
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
