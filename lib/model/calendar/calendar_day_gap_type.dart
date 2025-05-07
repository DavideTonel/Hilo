/// Defines the type of gap a calendar day represents in a month view.
///
/// [CalendarDayGapType] is typically used to distinguish whether a day
/// displayed in a calendar grid belongs to the previous month, the current
/// month, or the next month, which is useful for rendering complete weeks
/// in calendar UIs.
enum CalendarDayGapType {
  /// Represents a day that belongs to the previous month,
  /// shown in the current month's calendar grid to fill the starting week.
  prevMonth("GapPrev"),

  /// Represents a day that belongs to the current month.
  currentMonth("GapCurrent"),

  /// Represents a day that belongs to the next month,
  /// shown in the current month's calendar grid to complete the ending week.
  nextMonth("GapNext");

  /// The string value associated with the gap type, used for serialization or display.
  final String value;

  /// Creates a new instance of [CalendarDayGapType] with the specified [value].
  const CalendarDayGapType(this.value);
}
