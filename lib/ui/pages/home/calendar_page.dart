import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_tracker.dart';
import 'package:roadsyouwalked_app/model/media/memory_day_mapper.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/calendar_header.dart';
import 'package:roadsyouwalked_app/ui/components/calendar/calendar_widget.dart';
import 'package:roadsyouwalked_app/ui/components/controller/period_controller_widget.dart';
import 'package:roadsyouwalked_app/ui/constants/app_spacing.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final PageController _pageController;
  static const int initialPage = 1000;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = initialPage;
    _pageController = PageController(initialPage: _currentPage);
  }

  void _onPageChanged(int newPage) {
    final delta = newPage - _currentPage;
    _currentPage = newPage;

    final userId = context.read<UserBloc>().state.user?.username;
    final memoryState = context.read<MemoryBloc>().state;

    if (userId != null) {
      context.read<MemoryBloc>().add(
        SetTime(userId: userId, month: memoryState.month + delta),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoryBloc, MemoryState>(
      builder: (context, state) {
        final double itemHeight = 90;
        final double itemWidth = 50;

        return PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) {
            final offset = index - initialPage;
            final displayedMonth = state.month + offset;
            final tracker = CalendarTracker(displayedMonth, state.year);
            final displayedMap = MemoryDayMapper.mapMemoriesToDays(
              tracker.getDaysCurrentMonthWithGap(),
              state.memories,
            );

            return Column(
              children: [
                const SizedBox(height: AppSpacingConstants.xxs),
                PeriodControllerWidget(
                  header: DateFormat("MMM yyyy").format(
                    displayedMap.entries
                        .firstWhere(
                          (entry) =>
                              entry.key.gapType ==
                              CalendarDayGapType.currentMonth,
                        )
                        .key
                        .date,
                  ),
                  onPreviousPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeInOutCubicEmphasized,
                    );
                  },
                  onNextPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeInOutCubicEmphasized,
                    );
                  },
                ),
                const SizedBox(height: AppSpacingConstants.sm),
                CalendarHeader(
                  days: displayedMap.keys.toList(),
                  itemHeight: itemHeight / 2,
                  itemWidth: itemWidth,
                ),
                const SizedBox(height: AppSpacingConstants.xxs),
                CalendarWidget(
                  memoryMap: displayedMap,
                  itemHeight: itemHeight,
                  itemWidth: itemWidth,
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
