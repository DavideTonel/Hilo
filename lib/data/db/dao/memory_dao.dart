import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_core_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_data.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:developer' as dev;

class MemoryDao {
  final DatabaseManager _dbManager = DatabaseManager.instance;

  Future<List<Memory>> getMemoriesByUserId(final String userId) async {
    try {
      final db = await _dbManager.database;
      return await db.query(
        "Memory",
        where: "creatorId = ?",
        whereArgs: [userId],
        orderBy: "timestamp DESC"
      ).then((res) => res.map((map) => Memory(
        data: MemoryData(
          core: MemoryCoreData.fromMap(map),
        )
      )).toList());  // Memory FromMap I don't think would work. BasiData is plain with id attribute
    } catch (e) {
      dev.log("Error in MemoryDao");
      dev.log(e.toString());
      return [];
    }
  }

  Future<bool> insertMemory(final Memory memory, Transaction? transaction) async {
    try {
      final controller = transaction ?? await _dbManager.database;
      await controller.insert(
        "Memory",
        memory.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort
      );
      return true;
    } catch (e) {
      dev.log("Save in MemoryDao");
      dev.log(e.toString());
      // TODO: retrhrow exception
      return false;
    }
  }
}
