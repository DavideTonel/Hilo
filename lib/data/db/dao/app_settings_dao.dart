import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/settings/app_settings.dart';
import 'package:sqflite/sql.dart';
import 'dart:developer' as dev;

/// Data Access Object (DAO) class for managing application settings in the database.
class AppSettingsDao {
  // Instance of the DatabaseManager for accessing the database.
  final DatabaseManager _dbManager = DatabaseManager.instance;

  /// Retrieves the application settings from the database.
  ///
  /// This method queries the "Settings" table for the app settings using a fixed ID of 1.
  /// If no settings are found, it returns `null`.
  ///
  /// Returns an `AppSettings` object, or `null` if no settings are found.
  Future<AppSettings?> getSettings() async {
    try {
      final db = await _dbManager.database;
      final results = await db.query(
        "Settings",
        where: "id = ?",
        whereArgs: [ 1 ]
      );
      if (results.isNotEmpty) {
        return AppSettings.fromMap(results.first);
      } else {
        return null;
      }
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  /// Inserts or updates the application settings in the database.
  ///
  /// This method inserts a new `AppSettings` object into the "Settings" table.
  /// If the settings already exist, they are replaced with the new values.
  ///
  /// [settings] - The `AppSettings` object to be inserted or updated in the database.
  Future<void> insertSettings(
    final AppSettings settings,
  ) async {
    try {
      final db = await _dbManager.database;
      await db.insert(
        "Settings",
        settings.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
