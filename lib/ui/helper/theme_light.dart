/// Defines the available theme modes for the application's light and dark appearance.
///
/// This enum is used to control the app's visual theme behavior,
/// allowing users to select between a light mode, dark mode, or
/// system-defined theme.
enum ThemeLight {
  /// Forces the application to use the light theme.
  light(value: "light"),

  /// Forces the application to use the dark theme.
  dark(value: "dark"),

  /// Uses the system-defined theme (light or dark) based on device settings.
  system(value: "system");

  /// The string representation of the theme mode.
  final String value;

  /// Creates a [ThemeLight] enum value with the given [value].
  const ThemeLight({required this.value});

  /// Parses a string into a [ThemeLight] enum value.
  ///
  /// If the provided [value] does not match any known value,
  /// the default [ThemeLight.system] is returned.
  ///
  /// Example:
  /// ```dart
  /// final theme = ThemeLight.fromString("dark");
  /// ```
  factory ThemeLight.fromString(String value) {
    return ThemeLight.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ThemeLight.system,
    );
  }
}
