enum MapStyle {
  dawn(value: "dawn"),
  day(value: "day"),
  dusk(value: "dusk"),
  night(value: "night"),
  system(value: "system");

  final String value;

  const MapStyle({required this.value});

  factory MapStyle.fromString(String value) {
    return MapStyle.values.firstWhere(
      (e) => e.value == value,
      orElse: () => MapStyle.system,
    );
  }
}
