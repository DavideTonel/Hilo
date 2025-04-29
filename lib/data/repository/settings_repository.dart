import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/data/db/dao/app_settings_dao.dart';
import 'package:roadsyouwalked_app/model/settings/app_settings.dart';
import 'package:roadsyouwalked_app/ui/helper/map_style.dart';
import 'package:roadsyouwalked_app/ui/helper/theme_light.dart';

class SettingsRepository {
  final AppSettingsDao _settingsDao = AppSettingsDao();

  Future<AppSettings> getSetting() async {
    AppSettings? settings = await _settingsDao.getSettings();
    return settings ?? AppSettings(
      id: 1,
      mapStyle: MapStyle.system,
      theme: ThemeLight.system,
      themeSeedColor: Colors.green
    );
  }

  Future<void> saveSettings(final AppSettings settings) async {
    return await _settingsDao.insertSettings(settings);
  }
}
