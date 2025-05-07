import 'package:roadsyouwalked_app/data/db/dao/settings/i_app_settings_dao.dart';
import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/settings/app_settings.dart';
import 'package:sqflite/sql.dart';
import 'dart:developer' as dev;

/// Data Access Object (DAO) class for managing application settings in the database.
/// Concrete implementation of [IAppSettingsDao] for accessing and modifying
/// application settings stored in a local SQLite database.
class AppSettingsDao extends IAppSettingsDao {
  // Instance of the DatabaseManager for accessing the database.
  final DatabaseManager _dbManager = DatabaseManager.instance;

  @override
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

  @override
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
