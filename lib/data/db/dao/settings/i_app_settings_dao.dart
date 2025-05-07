import 'package:roadsyouwalked_app/model/settings/app_settings.dart';

/// Interface for accessing and modifying application settings stored in the database.
abstract class IAppSettingsDao {
  /// Retrieves the current [AppSettings] from the database, if available.
  ///
  /// Returns `null` if no settings are found.
  Future<AppSettings?> getSettings();

  /// Inserts or updates the given [settings] into the database.
  ///
  /// May overwrite the previous row depending on the conflict strategy used.
  Future<void> insertSettings(final AppSettings settings);
}
