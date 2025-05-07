/// A utility class that provides helper methods related to map style selection
/// based on the time of day.
///
/// This class follows the singleton pattern to ensure a single instance is used.
class MapStyleHelper {
  /// Private named constructor to prevent external instantiation.
  MapStyleHelper._();

  /// The single shared instance of [MapStyleHelper].
  static final MapStyleHelper instance = MapStyleHelper._();

  /// Returns a preset string for the light map style based on the given [dateTime].
  ///
  /// The returned preset is based on the hour of the day:
  /// - `"dawn"`: from 6:00 to 11:59
  /// - `"day"`: from 12:00 to 17:59
  /// - `"dusk"`: from 18:00 to 20:59
  /// - `"night"`: from 21:00 to 5:59
  ///
  /// This method is useful for applying dynamic theming to maps depending on
  /// the current time of day.
  ///
  /// Example:
  /// ```dart
  /// final preset = MapStyleHelper.instance.getLightPresetFromTime(DateTime.now());
  /// ```
  String getLightPresetFromTime(DateTime dateTime) {
    if (dateTime.hour >= 6 && dateTime.hour < 12) {
      return "dawn";
    } else if (dateTime.hour >= 12 && dateTime.hour < 18) {
      return "day";
    } else if (dateTime.hour >= 18 && dateTime.hour < 21) {
      return "dusk";
    } else {
      return "night";
    }
  }
}
