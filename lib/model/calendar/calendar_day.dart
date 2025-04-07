import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';

class CalendarDay {
  final DateTime date;
  final CalendarDayGapType gapType;

  CalendarDay(
    {
      required this.date,
      required this.gapType
    }
  );

  @override
  bool operator ==(Object other) {
    return other is CalendarDay &&
      date.year == other.date.year &&
      date.month == other.date.month &&
      date.day == other.date.day;
  }

  @override
  int get hashCode => Object.hash(date.year, date.month, date.day);
}
