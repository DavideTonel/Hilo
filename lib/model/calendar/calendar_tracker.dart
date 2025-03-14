import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';

class CalendarTracker {
  //final DateTime currentDate;
  List<CalendarDay> _gapDaysPrevCurrentMonth = [];
  List<CalendarDay> _gapDaysNextCurrentMonth = [];
  List<CalendarDay> _daysCurrentMonth = [];

  CalendarTracker(
    int month,
    int year
  ) {
    _daysCurrentMonth = _getDaysCurrentMonth(month, year);
    _gapDaysPrevCurrentMonth = _getGapDaysPrevCurrentMonth(_daysCurrentMonth);
    _gapDaysNextCurrentMonth = _getGapDaysNextCurrentMonth(_daysCurrentMonth);
  }

  int _getNumOfDaysInMonth(int month, int year) {
    return DateTime(year, month+1, 0).day;
  }

  List<CalendarDay> _getDaysCurrentMonth(int month, int year) {
    return List.generate(
      _getNumOfDaysInMonth(month, year),
      (i) => CalendarDay(date: DateTime(year, month, i+1), gapType: CalendarDayGapType.currentMonth)
    );
  }

  List<CalendarDay> _getGapDaysPrevCurrentMonth(List<CalendarDay> daysCurrentMonth) {
    List<CalendarDay> gapDays = [];
    DateTime firstDayOfMonth = daysCurrentMonth.first.date;
    DateTime prevDay = firstDayOfMonth.add(const Duration(days: -1));
    while (prevDay.weekday != 7) {    // 7 => sunday
      gapDays.insert(
        0,
        CalendarDay(
          date: prevDay,
          gapType: CalendarDayGapType.prevMonth
        )
      );
      prevDay = prevDay.add(const Duration(days: -1));
    }
    return gapDays;
  }

  List<CalendarDay> _getGapDaysNextCurrentMonth(List<CalendarDay> daysCurrentMonth) {
    List<CalendarDay> gapDays = [];
    DateTime lastDayOfMonth = daysCurrentMonth.last.date;
    DateTime nextDay = lastDayOfMonth.add(const Duration(days: 1));
    while (nextDay.weekday != 1) {    // 1 => monday
      gapDays.add(
        CalendarDay(
          date: nextDay,
          gapType: CalendarDayGapType.nextMonth
        )
      );
      nextDay = nextDay.add(const Duration(days: 1));
    }
    return gapDays;
  }

  List<CalendarDay> getDaysCurrentMonthWithGap() {
    return [..._gapDaysPrevCurrentMonth, ..._daysCurrentMonth, ..._gapDaysNextCurrentMonth];
  }
}
