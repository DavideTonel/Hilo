import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/settings/app_settings.dart';
import 'package:sqflite/sql.dart';
import 'dart:developer' as dev;

class AppSettingsDao {
  final DatabaseManager _dbManager = DatabaseManager.instance;

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
      dev.log("get settings error");
      dev.log(e.toString());
      return null;
    }
  }

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
      dev.log("Insert settings error");
      dev.log(e.toString());
    }
  }
}
