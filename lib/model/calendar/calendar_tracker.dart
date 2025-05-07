import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';

/// A utility class that generates and manages calendar days for a given month and year.
///
/// [CalendarTracker] is responsible for computing the days of the specified month,
/// as well as the gap days from the previous and next months to ensure full weeks
/// in a calendar grid. This is particularly useful for rendering a standard calendar
/// view where each week row starts on Monday and ends on Sunday.
class CalendarTracker {
  /// The selected month (1-based, e.g., January = 1).
  final int month;

  /// The selected year (e.g., 2025).
  final int year;

  late final List<CalendarDay> _gapDaysPrevCurrentMonth;
  late final List<CalendarDay> _gapDaysNextCurrentMonth;
  late final List<CalendarDay> _daysCurrentMonth;

  /// Creates a [CalendarTracker] for the specified [month] and [year],
  /// and computes all relevant days (including gap days) upon instantiation.
  CalendarTracker(this.month, this.year) {
    _daysCurrentMonth = _generateDaysInMonth();
    _gapDaysPrevCurrentMonth = _generateGapDaysBefore();
    _gapDaysNextCurrentMonth = _generateGapDaysAfter();
  }

  /// Generates the list of [CalendarDay]s representing all the days
  /// in the current month, with [gapType] set to [CalendarDayGapType.currentMonth].
  List<CalendarDay> _generateDaysInMonth() {
    final numDays = DateTime(year, month + 1, 0).day;

    return List.generate(
      numDays,
      (i) => CalendarDay(
        date: DateTime(year, month, i + 1),
        gapType: CalendarDayGapType.currentMonth,
      ),
    );
  }

  /// Generates the list of [CalendarDay]s from the **previous month**
  /// needed to fill the first week of the current month.
  ///
  /// These are prepended to the calendar grid to ensure that the first week
  /// starts on Monday.
  List<CalendarDay> _generateGapDaysBefore() {
    final List<CalendarDay> gapDays = [];

    if (_daysCurrentMonth.isEmpty) return gapDays;

    DateTime prevDay = _daysCurrentMonth.first.date.subtract(const Duration(days: 1));

    while (prevDay.weekday != DateTime.monday) {
      gapDays.insert(
        0,
        CalendarDay(date: prevDay, gapType: CalendarDayGapType.prevMonth),
      );
      prevDay = prevDay.subtract(const Duration(days: 1));
    }

    gapDays.insert(
      0,
      CalendarDay(date: prevDay, gapType: CalendarDayGapType.prevMonth),
    );

    return gapDays;
  }

  /// Generates the list of [CalendarDay]s from the **next month**
  /// needed to complete the final week of the current month.
  ///
  /// These are appended to the calendar grid to ensure that the final week
  /// ends on Sunday (or until the next Monday).
  List<CalendarDay> _generateGapDaysAfter() {
    final List<CalendarDay> gapDays = [];

    if (_daysCurrentMonth.isEmpty) return gapDays;

    DateTime nextDay = _daysCurrentMonth.last.date.add(const Duration(days: 1));

    while (nextDay.weekday != DateTime.monday) {
      gapDays.add(
        CalendarDay(date: nextDay, gapType: CalendarDayGapType.nextMonth),
      );
      nextDay = nextDay.add(const Duration(days: 1));
    }

    return gapDays;
  }

  /// Returns a full list of [CalendarDay]s including:
  /// - Previous month's gap days (if any)
  /// - Current month's days
  /// - Next month's gap days (if any)
  ///
  /// This is used to render the complete calendar grid with full weeks.
  List<CalendarDay> getDaysCurrentMonthWithGap() {
    return [
      ..._gapDaysPrevCurrentMonth,
      ..._daysCurrentMonth,
      ..._gapDaysNextCurrentMonth,
    ];
  }

  /// Returns only the days that belong to the current month,
  /// without including any gap days.
  List<CalendarDay> getDaysCurrentMonth() {
    return _generateDaysInMonth();
  }
}
