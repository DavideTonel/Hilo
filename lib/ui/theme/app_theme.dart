import 'package:flutter/material.dart';

class AppTheme {
  static final _lightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 247, 153, 184),
    brightness: Brightness.light,
  );

  static final _darkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: _lightColorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: _lightColorScheme.surfaceContainer,
      foregroundColor: _lightColorScheme.onPrimaryContainer,
      elevation: 0,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: _lightColorScheme.surfaceContainer,
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            fontWeight: FontWeight.w600,
            color: _lightColorScheme.onPrimaryContainer,
            fontSize: 12,
          );
        }
        return TextStyle(
          fontWeight: FontWeight.w400,
          color: _lightColorScheme.onPrimaryContainer.withAlpha(200),
          fontSize: 11
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(
            color: _lightColorScheme.onPrimaryContainer,
            weight: FontWeight.w600.value.toDouble(),
            size: 31,
          );
        }
        return IconThemeData(
          color: _lightColorScheme.onPrimaryContainer.withAlpha(200),
          size: 30,
        );
      }),
    ),

    textTheme: _textTheme,
    cardTheme: CardTheme(
      //color: _lightColorScheme.surfaceContainer,
      color: _lightColorScheme.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: _darkColorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: _darkColorScheme.surface,
      foregroundColor: _darkColorScheme.onSurface,
      elevation: 0,
    ),
    textTheme: _textTheme,
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  static const _textTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  );
}
