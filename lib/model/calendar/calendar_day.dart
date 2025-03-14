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
}
