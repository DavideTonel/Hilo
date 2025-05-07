import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

/// A utility class responsible for mapping memories to their respective calendar days.
///
/// This class provides functionality to associate memories with calendar days based on the memory's timestamp.
/// It ensures that memories are grouped correctly under the appropriate calendar day.
class MemoryDayMapper {
  /// Maps a list of [CalendarDay] objects to a list of [Memory] objects.
  ///
  /// This method creates a mapping between each calendar day and the memories that belong to it,
  /// based on the timestamp of each memory. If a calendar day does not have any associated memories,
  /// it will be associated with an empty list.
  ///
  /// Parameters:
  /// - [calendarDays]: A list of [CalendarDay] objects to map the memories to.
  /// - [memories]: A list of [Memory] objects to be mapped to the calendar days.
  ///
  /// Returns:
  /// A map where the keys are [CalendarDay] objects and the values are lists of associated [Memory] objects.
  static Map<CalendarDay, List<Memory>> mapMemoriesToDays(
    List<CalendarDay> calendarDays,
    List<Memory> memories,
  ) {
    final Map<DateTime, List<Memory>> memoryMap = {};
    
    for (final memory in memories) {
      final date = _truncateToDate(DateTime.parse(memory.data.core.timestamp));
      memoryMap.putIfAbsent(date, () => []).add(memory);
    }

    final Map<CalendarDay, List<Memory>> result = {};
    
    for (final day in calendarDays) {
      final dayKey = _truncateToDate(day.date);
      result[day] = memoryMap[dayKey] ?? [];
    }

    return result;
  }

  /// Truncates the time component of a [DateTime] object, leaving only the date (year, month, day).
  ///
  /// This helper method ensures that the time component is removed so that comparisons are made based on the date only.
  static DateTime _truncateToDate(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }
}
