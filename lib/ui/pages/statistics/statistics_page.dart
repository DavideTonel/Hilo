import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';
import 'package:roadsyouwalked_app/ui/components/statistics/line_chart/last_n_day_evaluation_line_chart_widget.dart';
import 'package:roadsyouwalked_app/ui/pages/statistics/last_n_days_statistics_page.dart';
import 'package:roadsyouwalked_app/ui/pages/statistics/month_statistics_page.dart';
import 'package:roadsyouwalked_app/ui/pages/statistics/year_statistics_page.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoryBloc, MemoryState>(
      builder: (context, state) {
        Widget page;
        switch (state.orderType) {
          case MemoryOrderType.lastNDays:
            page = LastNDaysStatisticsPage(
              memories: state.memories,
              fromDate: DateTime.now(),
              lastNDays: state.lastNDays,
            );
            break;
          case MemoryOrderType.byMonth:
            page = MonthStatisticsPage(
              memories: state.memories,
              month: state.month,
              year: state.year,
              onPreviousPressed:
                  () => context.read<MemoryBloc>().add(
                    SetTime(
                      userId: context.read<UserBloc>().state.user!.username,
                      month: state.month - 1,
                    ),
                  ),
              onNextPressed:
                  () => context.read<MemoryBloc>().add(
                    SetTime(
                      userId: context.read<UserBloc>().state.user!.username,
                      month: state.month + 1,
                    ),
                  ),
            );
            break;
          case MemoryOrderType.byYear:
            page = YearStatisticsPage(
              memories: state.memories,
              year: state.year,
              onPreviousPressed:
                  () => context.read<MemoryBloc>().add(
                    SetTime(
                      userId: context.read<UserBloc>().state.user!.username,
                      year: state.year - 1,
                    ),
                  ),
              onNextPressed:
                  () => context.read<MemoryBloc>().add(
                    SetTime(
                      userId: context.read<UserBloc>().state.user!.username,
                      year: state.year + 1,
                    ),
                  ),
            );
            break;
          default:
            page = LastNDayEvaluationLineChartWidget(
              memories: state.memories,
              fromDate: DateTime.now(),
              lastNDays: state.lastNDays,
            );
        }
        return page;
        /*
        return MoodCharts(
          dates: [DateTime.now().subtract(const Duration(days: 2)), DateTime.now().subtract(const Duration(days: 1)), DateTime.now()],
          positiveScores: [0.5, 0.8, 0.2],
          negativeScores: [0.2, 0.1, 0.6],
        );
        */
        /*
        return BarChartAffiancato(
          dates: [DateTime.now().subtract(const Duration(days: 2)), DateTime.now().subtract(const Duration(days: 1)), DateTime.now()],
          positiveScores: [5, 8, 2],
          negativeScores: [2, 1, 6],
        );
        */
      },
    );
  }
}


// Assicurati di avere fl_chart nel pubspec.yaml
// fl_chart: ^0.64.0 (o versione più recente)
class MoodCharts extends StatelessWidget {
  final List<DateTime> dates;
  final List<double> positiveScores;
  final List<double> negativeScores;

  const MoodCharts({
    super.key,
    required this.dates,
    required this.positiveScores,
    required this.negativeScores,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Stacked Area Chart"),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(positiveScores.length, (i) => FlSpot(i.toDouble(), positiveScores[i])),
                      isCurved: true,
                      color: Colors.green.withOpacity(0.5),
                      belowBarData: BarAreaData(show: true, color: Colors.green.withOpacity(0.3)),
                    ),
                    LineChartBarData(
                      spots: List.generate(negativeScores.length, (i) => FlSpot(i.toDouble(), negativeScores[i])),
                      isCurved: true,
                      color: Colors.red.withOpacity(0.5),
                      belowBarData: BarAreaData(show: true, color: Colors.red.withOpacity(0.3)),
                    ),
                  ],
                ),
              ),
            ),
        
            const SizedBox(height: 16),
            const Text("Scatter Chart"),
            SizedBox(
              height: 200,
              child: ScatterChart(
                ScatterChartData(
                  scatterSpots: List.generate(
                    dates.length,
                    (i) => ScatterSpot(i.toDouble(), positiveScores[i]),
                  ) +
                      List.generate(
                        dates.length,
                        (i) => ScatterSpot(i.toDouble(), negativeScores[i]),
                      ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                ),
              ),
            ),
        
            const SizedBox(height: 16),
            const Text("Radar Chart (mocked)"),
            SizedBox(
              height: 200,
              child: RadarChart(
                RadarChartData(
                  dataSets: [
                    RadarDataSet(
                      fillColor: Colors.green.withOpacity(0.4),
                      borderColor: Colors.green,
                      entryRadius: 3,
                      dataEntries: positiveScores.take(6).map((e) => RadarEntry(value: e)).toList(),
                    ),
                    RadarDataSet(
                      fillColor: Colors.red.withOpacity(0.4),
                      borderColor: Colors.red,
                      entryRadius: 3,
                      dataEntries: negativeScores.take(6).map((e) => RadarEntry(value: e)).toList(),
                    ),
                  ],
                  radarBackgroundColor: Colors.transparent,
                  borderData: FlBorderData(show: false),
                  titleTextStyle: const TextStyle(fontSize: 12),
                ),
              ),
            ),
        
            const SizedBox(height: 16),
            const Text("Mini Dashboard"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text("Last Pos."),
                    Text(positiveScores.last.toStringAsFixed(1), style: const TextStyle(fontSize: 18, color: Colors.green))
                  ],
                ),
                Column(
                  children: [
                    const Text("Last Neg."),
                    Text(negativeScores.last.toStringAsFixed(1), style: const TextStyle(fontSize: 18, color: Colors.red))
                  ],
                ),
                Column(
                  children: [
                    const Text("Trend"),
                    Icon(
                      (positiveScores.last - positiveScores.first) > 0 ? Icons.trending_up : Icons.trending_down,
                      color: (positiveScores.last - positiveScores.first) > 0 ? Colors.green : Colors.red,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BarChartAffiancato extends StatelessWidget {
  final List<DateTime> dates;
  final List<double> positiveScores;
  final List<double> negativeScores;

  const BarChartAffiancato({
    super.key,
    required this.dates,
    required this.positiveScores,
    required this.negativeScores,
  });

  @override
  Widget build(BuildContext context) {
    final barGroups = <BarChartGroupData>[];

    for (int i = 0; i < dates.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: positiveScores[i],
              color: Colors.green,
              width: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            BarChartRodData(
              toY: negativeScores[i],
              color: Colors.red,
              width: 8,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
          barsSpace: 4,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: barGroups,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= dates.length) return const SizedBox.shrink();
                  final date = dates[index];
                  return Text(
                    '${date.day}/${date.month}',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final label = rodIndex == 0 ? 'Positivo' : 'Negativo';
                return BarTooltipItem(
                  '$label: ${rod.toY.toStringAsFixed(1)}',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
