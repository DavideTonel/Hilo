import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/data/db/dao/app_settings_dao.dart';
import 'package:roadsyouwalked_app/model/settings/app_settings.dart';
import 'package:roadsyouwalked_app/ui/helper/map_style.dart';
import 'package:roadsyouwalked_app/ui/helper/theme_light.dart';

/// A repository class responsible for managing application settings.
class SettingsRepository {
  final AppSettingsDao _settingsDao = AppSettingsDao();

  /// Retrieves the current application settings.
  ///
  /// If no settings are found, it returns default settings with:
  /// - `mapStyle` set to `MapStyle.system`,
  /// - `theme` set to `ThemeLight.system`,
  /// - `themeSeedColor` set to `Colors.green`.
  ///
  /// Returns an `AppSettings` object containing the settings.
  Future<AppSettings> getSetting() async {
    AppSettings? settings = await _settingsDao.getSettings();
    return settings ?? AppSettings(
      id: 1,
      mapStyle: MapStyle.system,
      theme: ThemeLight.system,
      themeSeedColor: Colors.green,
    );
  }

  /// Saves the provided application settings to the database.
  ///
  /// This method inserts or updates the given `AppSettings`.
  ///
  /// [settings] - The `AppSettings` object containing the settings to be saved.
  Future<void> saveSettings(final AppSettings settings) async {
    return await _settingsDao.insertSettings(settings);
  }
}
