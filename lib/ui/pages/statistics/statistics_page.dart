import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_tracker.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MemoryBloc, MemoryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return LastNDayEvaluationChartWidget(
          memories: state.memories,
          fromDate: DateTime.now(),
          lastNDays: 7
        );
      },
    );
  }
}

class LastNDayEvaluationChartWidget extends StatelessWidget {
  final List<Memory> memories;
  final DateTime fromDate;
  final int lastNDays;

  const LastNDayEvaluationChartWidget({super.key, required this.memories, required this.fromDate, required this.lastNDays});

  List<FlSpot> _getLastNMidnightForXAxisLabel({required final DateTime fromDate, required final int lastNDays}) {
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
      for (final String label in memories.first.data.evaluation.evaluationResult.keys) {
        List<FlSpot> labeledSpots = memories.map((memory) => FlSpot(DateTime.parse(memory.data.core.timestamp).millisecondsSinceEpoch.toDouble(), memory.data.evaluation.evaluationResult[label]!)).toList();
        spotsGroupByLabel[label] = labeledSpots;
      }
    }
    return spotsGroupByLabel;
  }

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> lastNMidnights = _getLastNMidnightForXAxisLabel(fromDate: fromDate, lastNDays: lastNDays);
    final Map<String, List<FlSpot>> spotsGroupByLabel = _getSpotsGroupByLabel(memories);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
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
                      colors: [Colors.transparent, entry.key == "positive" ? Colors.green : Colors.red],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter
                    )
                  )
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
                    if (DateTime.fromMillisecondsSinceEpoch(value.toInt()).difference(DateTime.fromMillisecondsSinceEpoch(lastNMidnights.first.x.toInt())) < Duration(hours: 1)) {
                      return const SizedBox.shrink();
                    }
                    final label = DateFormat('dd MMM').format(
                      DateTime.fromMillisecondsSinceEpoch(value.floor()),
                    );
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
                      return Text(
                        "Low",
                        style: const TextStyle(fontSize: 12),
                      );
                    } else if (value == 25) {
                      return Text(
                        "High",
                        style: const TextStyle(fontSize: 12),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(
              border: Border(left: BorderSide(), bottom: BorderSide()),
            ),
          ),
        ),
      ),
    );
  }
}

class MonthEvaluationChartWidget extends StatelessWidget {    // analizza i giorni nel mese
  final List<Memory> memories;
  final int month;
  final int year;

  const MonthEvaluationChartWidget({super.key, required this.memories, required this.month, required this.year});

  List<FlSpot> _getDaysForXAxis(final int month, final int year) {
    return CalendarTracker(month, year).getDaysCurrentMonth().map((day) => FlSpot(day.date.day.toDouble(), 0)).toList();
  }

  Map<String, List<FlSpot>> _getSpotsGroupByLabel(final List<Memory> memories) {
    final Map<DateTime, List<Memory>> groupedByDay = {};

    for (final memory in memories) {
      final timestamp = DateTime.parse(memory.data.core.timestamp);
      final date = DateTime(timestamp.year, timestamp.month, timestamp.day); // solo giorno

      groupedByDay.putIfAbsent(date, () => []).add(memory);
    }

    // Insieme di tutte le label usate in almeno una memoria
    final Set<String> allLabels = {
      for (final m in memories) ...m.data.evaluation.evaluationResult.keys,
    };

    // Mappa finale
    final Map<String, List<FlSpot>> result = {
      for (final label in allLabels) label: [],
    };

    for (final entry in groupedByDay.entries) {
      final day = entry.key;
      final memoriesOfDay = entry.value;

      // Per ogni label, calcola la media delle valutazioni disponibili in quel giorno
      for (final label in allLabels) {
        final values = memoriesOfDay
          .map((m) => m.data.evaluation.evaluationResult[label])
          .where((v) => v != null)
          .cast<double>()
          .toList();

        if (values.isNotEmpty) {
          final average = values.reduce((a, b) => a + b) / values.length;
          final x = day.millisecondsSinceEpoch.toDouble();
          final y = average;
          result[label]!.add(FlSpot(x, y));
        }
      }
    }
    return result;
  }
  
  @override
  Widget build(BuildContext context) {
    List<FlSpot> daysInMonth = _getDaysForXAxis(month, year);
    Map<String, List<FlSpot>> spotsGroupByLabel = _getSpotsGroupByLabel(memories);

    return LineChart(
      LineChartData(
        maxY: 25,
        minY: 0,
        minX: daysInMonth.first.x,
        maxX: daysInMonth.last.x,
        lineBarsData: [
          LineChartBarData(
            show: false,
            spots: daysInMonth,
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
                  colors: [Colors.transparent, entry.key == "positive" ? Colors.green : Colors.red],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                )
              )
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
                //if (DateTime.fromMillisecondsSinceEpoch(value.toInt()).difference(DateTime.fromMillisecondsSinceEpoch(lastNMidnights.first.x.toInt())) < Duration(hours: 1)) {
                  //return const SizedBox.shrink();
                //}
                final label = DateFormat('d').format(
                  DateTime.fromMillisecondsSinceEpoch(value.floor()),
                );
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
                  return Text(
                    "Low",
                    style: const TextStyle(fontSize: 12),
                  );
                } else if (value == 25) {
                  return Text(
                    "High",
                    style: const TextStyle(fontSize: 12),
                  );
                } else {
                  return SizedBox.shrink();
                }
                  },
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(
          border: Border(left: BorderSide(), bottom: BorderSide()),
        ),
      ),
    );
  }
}
