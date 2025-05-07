/// An enumeration representing the different types of memory ordering.
///
/// This enum defines the various ways in which memories can be ordered or categorized.
enum MemoryOrderType {
  /// Order memories based on the timeline.
  /// This is the default order, showing memories as they occurred in time.
  timeline(value: "Timeline"),

  /// Order memories by month.
  /// This groups memories based on the month in which they were created.
  byMonth(value: "Month"),

  /// Order memories by year.
  /// This groups memories based on the year in which they were created.
  byYear(value: "Year"),

  /// Order memories based on the last N days.
  /// This orders memories by how recently they were created, filtering the last N days.
  lastNDays(value: "Last days");

  final String value;

  /// The constructor that initializes each enum value with a string representation.
  const MemoryOrderType({required this.value});
}
