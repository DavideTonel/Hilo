import 'package:roadsyouwalked_app/model/calendar/calendar_day.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

class MemoryDayMapper {
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

  static DateTime _truncateToDate(DateTime dt) {
    return DateTime(dt.year, dt.month, dt.day);
  }
}
