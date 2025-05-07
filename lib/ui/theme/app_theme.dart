import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roadsyouwalked_app/ui/helper/theme_light.dart';

class AppTheme {
  static ThemeData lightTheme(ColorScheme colorSchemeLight) {
    return ThemeData(
      colorScheme: colorSchemeLight,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: colorSchemeLight.primary,
          systemNavigationBarColor: null,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: colorSchemeLight.onSurfaceVariant,
        iconTheme: IconThemeData(color: colorSchemeLight.onSurfaceVariant),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorSchemeLight.onSurfaceVariant,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFEDEDED),
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colorSchemeLight.onSurface,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
          final isSelected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: isSelected ? 28 : 26,
            color: isSelected
                ? colorSchemeLight.primary
                : colorSchemeLight.onSurfaceVariant,
          );
        }),
      ),
      textTheme: Typography.blackCupertino.apply(
        bodyColor: colorSchemeLight.onSurfaceVariant,
        displayColor: colorSchemeLight.onSurfaceVariant,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: const Color(0xFFF0F0F0),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        scrimColor: Colors.black38,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
    );
  }

  static ThemeData darkTheme(ColorScheme colorSchemeDark) {
    return ThemeData(
      colorScheme: colorSchemeDark,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color.fromARGB(255, 22, 22, 22),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: colorSchemeDark.onSurfaceVariant,
        iconTheme: IconThemeData(color: colorSchemeDark.onSurfaceVariant),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorSchemeDark.onSurfaceVariant,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF1A1A1A).withAlpha(250),
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelTextStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colorSchemeDark.onSurface,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
          final isSelected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: isSelected ? 28 : 26,
            color: isSelected
                ? colorSchemeDark.primary
                : colorSchemeDark.onSurfaceVariant,
          );
        }),
      ),
      textTheme: Typography.whiteCupertino.apply(
        bodyColor: colorSchemeDark.onSurfaceVariant,
        displayColor: colorSchemeDark.onSurfaceVariant,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        scrimColor: Colors.black54,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
      ),
    );
  }

  static ThemeMode getThemeMode(ThemeLight themeLight) {
    switch (themeLight) {
      case ThemeLight.light:
        return ThemeMode.light;
      case ThemeLight.dark:
        return ThemeMode.dark;
      case ThemeLight.system:
        return ThemeMode.system;
    }
  }
}
