enum MemoryOrderType {
  timeline(value: "Timeline"),
  byMonth(value: "Month"),
  byYear(value: "Year"),
  lastNDays(value: "Last days");

  final String value;

  const MemoryOrderType({required this.value});
}
