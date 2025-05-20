import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:roadsyouwalked_app/bloc/memory/memory_bloc.dart';
import 'package:roadsyouwalked_app/bloc/user/user_bloc.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_tracker.dart';
import 'package:roadsyouwalked_app/model/calendar/memory_day_mapper.dart';
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
  static const int initialPage = 1000;
  late final PageController _pageController;

  // Holds the month/year captured from the bloc on first build
  int? _baseMonth;
  int? _baseYear;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: initialPage);
  }

  void _onPageChanged(int newPage) {
    final userId = context.read<UserBloc>().state.user?.username;
    if (userId == null) return;

    final offset   = newPage - initialPage;
    final rawMonth = (_baseMonth! - 1) + offset;
    final yearDelta= (rawMonth / 12).floor();
    final newMonth = rawMonth - yearDelta * 12 + 1;
    final newYear  = _baseYear! + yearDelta;

    context.read<MemoryBloc>().add(
      SetTime(
        userId: userId,
        year:  newYear,
        month: newMonth,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemoryBloc, MemoryState>(
      builder: (context, state) {
        // Capture the base month/year once on first build
        if (_baseMonth == null) {
          _baseMonth = state.month;
          _baseYear  = state.year;
        }

        final size = MediaQuery.of(context).size;
        final double itemWidth = size.width / 8.6;
        final double itemHeight = (size.height - 200) / 7.5;

        return PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemBuilder: (context, index) {
            final offset    = index - initialPage;
            final rawMonth  = (_baseMonth! - 1) + offset;
            final yearDelta = (rawMonth / 12).floor();
            final displayedMonth = rawMonth - yearDelta * 12 + 1;
            final displayedYear  = _baseYear! + yearDelta;

            final tracker = CalendarTracker(displayedMonth, displayedYear);
            final daysWithGap = tracker.getDaysCurrentMonthWithGap();
            final displayedMap = MemoryDayMapper.mapMemoriesToDays(
              daysWithGap,
              state.memories,
            );

            final headerDate = displayedMap.entries
              .firstWhere((e) => e.key.gapType == CalendarDayGapType.currentMonth)
              .key
              .date;

            return Column(
              children: [
                const SizedBox(height: AppSpacingConstants.xxs),
                PeriodControllerWidget(
                  header: DateFormat("MMM yyyy").format(headerDate),
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
