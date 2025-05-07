import 'dart:ui';

import 'package:color_hex/color_hex.dart';
import 'package:roadsyouwalked_app/ui/helper/map_style.dart';
import 'package:roadsyouwalked_app/ui/helper/theme_light.dart';

/// Represents the application settings.
class AppSettings {
  /// Unique identifier for the settings instance.
  final int id;

  /// The selected map style used in the application.
  final MapStyle mapStyle;

  /// The selected light theme configuration.
  final ThemeLight theme;

  /// The seed color used for generating the application theme.
  final Color themeSeedColor;

  /// Creates a new instance of [AppSettings].
  ///
  /// All parameters are required.
  AppSettings({
    required this.id,
    required this.mapStyle,
    required this.theme,
    required this.themeSeedColor,
  });

  /// Creates a copy of the current [AppSettings] with optional new values.
  ///
  /// This method returns a new instance with updated values for the provided
  /// parameters while keeping the others unchanged.
  AppSettings copyWith({
    MapStyle? newMapStyle,
    ThemeLight? newTheme,
    Color? newThemeSeedColor,
  }) {
    return AppSettings(
      id: id,
      mapStyle: newMapStyle ?? mapStyle,
      theme: newTheme ?? theme,
      themeSeedColor: newThemeSeedColor ?? themeSeedColor,
    );
  }

  /// Converts the [AppSettings] instance to a map suitable for serialization.
  ///
  /// Useful for storing the settings in a database or shared preferences.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "mapStyle": mapStyle.value,
      "themeLight": theme.value,
      "themeSeedColor": themeSeedColor.convertToHex.hex,
    };
  }

  /// Creates an [AppSettings] instance from a serialized map.
  ///
  /// Expects the map to contain string representations of [MapStyle],
  /// [ThemeLight], and a hex string for [Color].
  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      id: map["id"] as int,
      mapStyle: MapStyle.fromString(map["mapStyle"] as String),
      theme: ThemeLight.fromString(map["themeLight"] as String),
      themeSeedColor: hexToColor(map["themeSeedColor"] as String),
    );
  }
}
