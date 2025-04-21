import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';

class CalendarTracker {
  final int month;
  final int year;

  late final List<CalendarDay> _gapDaysPrevCurrentMonth;
  late final List<CalendarDay> _gapDaysNextCurrentMonth;
  late final List<CalendarDay> _daysCurrentMonth;

  CalendarTracker(this.month, this.year) {
    _daysCurrentMonth = _generateDaysInMonth();
    _gapDaysPrevCurrentMonth = _generateGapDaysBefore();
    _gapDaysNextCurrentMonth = _generateGapDaysAfter();
  }

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

  List<CalendarDay> getDaysCurrentMonthWithGap() {
    return [
      ..._gapDaysPrevCurrentMonth,
      ..._daysCurrentMonth,
      ..._gapDaysNextCurrentMonth,
    ];
  }

  List<CalendarDay> getDaysCurrentMonth() {
    return _generateDaysInMonth();
  }
}
