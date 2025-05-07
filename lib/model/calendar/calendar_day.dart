import 'package:roadsyouwalked_app/model/calendar/calendar_day_gap_type.dart';

/// Represents a single day in a calendar view, including its date
/// and its position relative to the currently displayed month.
///
/// [CalendarDay] is used to build calendar grids where each cell
/// must contain both the specific [DateTime] and the [CalendarDayGapType]
/// to indicate whether it belongs to the current, previous, or next month.
class CalendarDay {
  /// The calendar date represented by this instance.
  final DateTime date;

  /// Indicates whether the date belongs to the current, previous, or next month.
  ///
  /// This is useful for styling and rendering days differently based on their context
  /// in the calendar view.
  final CalendarDayGapType gapType;

  /// Creates a [CalendarDay] with the given [date] and [gapType].
  CalendarDay({
    required this.date,
    required this.gapType,
  });

  /// Compares two [CalendarDay] instances based on their [date] values only.
  ///
  /// The [gapType] is intentionally excluded from equality checks to treat days
  /// with the same date as equal, regardless of their month context.
  @override
  bool operator ==(Object other) {
    return other is CalendarDay &&
      date.year == other.date.year &&
      date.month == other.date.month &&
      date.day == other.date.day;
  }

  /// Generates a hash code based on the year, month, and day of the [date].
  ///
  /// This ensures consistent hashing for [CalendarDay] objects that fall on
  /// the same calendar day.
  @override
  int get hashCode => Object.hash(date.year, date.month, date.day);
}
