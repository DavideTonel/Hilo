import 'package:roadsyouwalked_app/data/db/dao/memory/i_memory_dao.dart';
import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_data.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:developer' as dev;

/// Data Access Object (DAO) class for managing memory-related operations in the database.
/// /// Concrete implementation of [IMemoryDao].
class MemoryDao extends IMemoryDao {
  // Instance of the DatabaseManager for accessing the database.
  final DatabaseManager _dbManager = DatabaseManager.instance;

  @override
  Future<List<Memory>> getMemoriesByUserId(final String userId) async {
    try {
      final db = await _dbManager.database;
      return await db.query(
        "Memory",
        where: "creatorId = ?",
        whereArgs: [userId],
        orderBy: "timestamp DESC"
      ).then((res) => res.map((map) => Memory(
        data: MemoryData.fromMap(map)
      )).toList());
    } catch (e) {
      dev.log(e.toString());
      return [];
    }
  }

  @override
  Future<List<Memory>> getMemoriesByUserIdFromDate(final String userId, final DateTime fromDate) async {
    try {
      final db = await _dbManager.database;
      return await db.query(
        "Memory",
        where: "creatorId = ? AND timestamp >= ?",
        whereArgs: [userId, fromDate.toIso8601String()],
        orderBy: "timestamp ASC"
      ).then((res) => res.map((map) => Memory(
        data: MemoryData.fromMap(map)
      )).toList());
    } catch (e) {
      dev.log(e.toString());
      return [];
    }
  }

  @override
  Future<List<Memory>> getMemoriesByUserIdAndTime(final String userId, final String year, final String month) async {
    try {
      final db = await _dbManager.database;
      return await db.query(
        "Memory",
        where: "creatorId = ? AND strftime('%Y', timestamp) = ? AND strftime('%m', timestamp) = ?",
        whereArgs: [userId, year, month],
        orderBy: "timestamp ASC"
      ).then((res) => res.map((map) => Memory(
        data: MemoryData.fromMap(map)
      )).toList());
    } catch (e) {
      dev.log(e.toString());
      return [];
    }
  }

  @override
  Future<List<Memory>> getMemoriesByUserIdInYear(final String userId, final String year) async {
    try {
      final db = await _dbManager.database;
      return await db.query(
        "Memory",
        where: "creatorId = ? AND strftime('%Y', timestamp) = ?",
        whereArgs: [userId, year],
        orderBy: "timestamp ASC"
      ).then((res) => res.map((map) => Memory(
        data: MemoryData.fromMap(map)
      )).toList());
    } catch (e) {
      dev.log(e.toString());
      return [];
    }
  }

  @override
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
      dev.log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> isValidId(final String memoryId, final String creatorId) async {
    try {
      final db = await _dbManager.database;
      return await db.query(
        "Memory",
        where: "creatorId = ? AND id = ?",
        whereArgs: [creatorId, memoryId]
      ).then((res) => res.isEmpty);
    } catch (e) {
      dev.log(e.toString());
      return false;
    }
  }
}
