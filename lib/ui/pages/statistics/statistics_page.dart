import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/model/memory/memory_order_type.dart';
import 'package:roadsyouwalked_app/ui/components/statistics/line_chart/last_n_day_evaluation_line_chart_widget.dart';
import 'package:roadsyouwalked_app/ui/components/statistics/mode_selector_widget.dart';
import 'package:roadsyouwalked_app/ui/pages/statistics/last_n_days_statistics_page.dart';
import 'package:roadsyouwalked_app/ui/pages/statistics/month_statistics_page.dart';
import 'package:roadsyouwalked_app/ui/pages/statistics/year_statistics_page.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoryBloc, MemoryState>(
      builder: (context, state) {
        Widget body;
        switch (state.orderType) {
          case MemoryOrderType.lastNDays:
            body = LastNDaysStatisticsPage(
              memories: state.memories,
              fromDate: DateTime.now(),
              lastNDays: state.lastNDays,
            );
            break;
          case MemoryOrderType.byMonth:
            body = MonthStatisticsPage(
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
            body = YearStatisticsPage(
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
            body = LastNDayEvaluationLineChartWidget(
              memories: state.memories,
              fromDate: DateTime.now(),
              lastNDays: state.lastNDays,
            );
        }

        return Scaffold(
          appBar: AppBar(
            title: ModeSelectorWidget(
              modes: [
                MemoryOrderType.lastNDays,
                MemoryOrderType.byMonth,
                MemoryOrderType.byYear,
              ],
              selectedMode: state.orderType,
              onSelect: (mode) {
                context.read<MemoryBloc>().add(
                  LoadMemories(
                    userId: context.read<UserBloc>().state.user!.username,
                    orderType: mode,
                    year: state.year,
                    month: state.month,
                    lastNDays: state.lastNDays,
                  ),
                );
              },
            ),
          ),
          body: body,
        );
      },
    );
  }
}
