/// An enumeration that defines the different map style presets available in the application.
///
/// These styles are typically used to customize the visual appearance of maps based
/// on the time of day or user preferences.
enum MapStyle {
  /// Map style for early morning.
  dawn(value: "dawn"),

  /// Map style for midday and early afternoon.
  day(value: "day"),

  /// Map style for early evening hours.
  dusk(value: "dusk"),

  /// Map style for night hours.
  night(value: "night"),

  /// Follows the default behavior.
  system(value: "system");

  /// The string value associated with the enum case.
  final String value;

  /// Creates a [MapStyle] enum case with the given [value].
  const MapStyle({required this.value});

  /// Parses a string into a [MapStyle] enum case.
  ///
  /// If the provided [value] does not match any known case,
  /// [MapStyle.system] is returned as a default fallback.
  ///
  /// Example:
  /// ```dart
  /// final style = MapStyle.fromString("dawn");
  /// ```
  factory MapStyle.fromString(String value) {
    return MapStyle.values.firstWhere(
      (e) => e.value == value,
      orElse: () => MapStyle.system,
    );
  }
}
