import 'dart:ui';

import 'package:color_hex/color_hex.dart';
import 'package:roadsyouwalked_app/ui/helper/map_style.dart';
import 'package:roadsyouwalked_app/ui/helper/theme_light.dart';

class AppSettings {
  final int id;
  final MapStyle mapStyle;
  final ThemeLight theme;
  final Color themeSeedColor;

  AppSettings({required this.id, required this.mapStyle, required this.theme, required this.themeSeedColor});

  AppSettings copyWith({
    MapStyle? newMapStyle,
    ThemeLight? newTheme,
    Color? newThemeSeedColor
  }) {
    return AppSettings(
      id: id,
      mapStyle: newMapStyle ?? mapStyle ,
      theme: newTheme ?? theme,
      themeSeedColor: newThemeSeedColor ?? themeSeedColor
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "mapStyle": mapStyle.value,
      "themeLight": theme.value,
      "themeSeedColor": themeSeedColor.convertToHex.hex,
    };
  }

  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      id: map["id"] as int,
      mapStyle: MapStyle.fromString(map["mapStyle"] as String),
      theme: ThemeLight.fromString(map["themeLight"] as String),
      themeSeedColor: hexToColor(map["themeSeedColor"] as String)
    );
  }
}
