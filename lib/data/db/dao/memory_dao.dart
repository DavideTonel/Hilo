import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:sqflite/sqflite.dart';

class MemoryDao {
  final DatabaseManager _dbManager = DatabaseManager.instance;

  Future<List<Memory>> getMemoriesByUserId(final String username) async {
    try {
      final db = await _dbManager.database;
      return await db.query(
        "Memory",
        where: "username = ?",
        whereArgs: [username],
        orderBy: "timestap DESC"
      ).then((res) => res.map((map) => Memory.fromMap(map)).toList());  // Memory FromMap I don't think would work. BasiData is plain with id attribute
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveMemory(final Memory memory) async {
    try {
      final db = await _dbManager.database;
      await db.insert(
        "Memory",
        memory.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
