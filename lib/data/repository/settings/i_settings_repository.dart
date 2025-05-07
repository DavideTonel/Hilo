import 'package:roadsyouwalked_app/model/settings/app_settings.dart';

/// Interface for managing settings-related data.
abstract class ISettingsRepository {
  /// Retrieves the current application settings.
  ///
  /// Returns an `AppSettings` object containing the settings.
  Future<AppSettings> getSetting();

  /// Saves the provided application settings to the database.
  ///
  /// This method inserts or updates the given `AppSettings`.
  ///
  /// [settings] - The `AppSettings` object containing the settings to be saved.
  Future<void> saveSettings(final AppSettings settings);
}