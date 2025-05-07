import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_data.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:developer' as dev;

/// Data Access Object (DAO) class for managing memory-related operations in the database.
class MemoryDao {
  // Instance of the DatabaseManager for accessing the database.
  final DatabaseManager _dbManager = DatabaseManager.instance;

  /// Retrieves all memories associated with a specific user.
  ///
  /// This method queries the "Memory" table to fetch all memories for a given user ID.
  ///
  /// [userId] - The user ID whose memories are to be retrieved.
  ///
  /// Returns a list of `Memory` objects associated with the provided user ID, ordered by timestamp in descending order.
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

  /// Retrieves memories for a user starting from a specific date.
  ///
  /// This method queries the "Memory" table to fetch memories for a given user ID and a start date.
  ///
  /// [userId] - The user ID whose memories are to be retrieved.
  /// [fromDate] - The start date to filter memories from.
  ///
  /// Returns a list of `Memory` objects that are associated with the provided user ID and have a timestamp greater than or equal to the provided date.
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

  /// Retrieves memories for a user within a specific month and year.
  ///
  /// This method queries the "Memory" table to fetch memories for a given user ID, year, and month.
  ///
  /// [userId] - The user ID whose memories are to be retrieved.
  /// [year] - The year to filter memories by.
  /// [month] - The month to filter memories by.
  ///
  /// Returns a list of `Memory` objects associated with the provided user ID, year, and month, ordered by timestamp in ascending order.
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

  /// Retrieves memories for a user within a specific year.
  ///
  /// This method queries the "Memory" table to fetch memories for a given user ID and year.
  ///
  /// [userId] - The user ID whose memories are to be retrieved.
  /// [year] - The year to filter memories by.
  ///
  /// Returns a list of `Memory` objects associated with the provided user ID and year, ordered by timestamp in ascending order.
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

  /// Inserts a new memory into the database.
  ///
  /// This method inserts a new memory into the "Memory" table.
  ///
  /// [memory] - The `Memory` object to be inserted into the database.
  /// [transaction] - An optional database transaction to be used for the insert operation.
  ///
  /// Returns `true` if the memory was successfully inserted, otherwise `false`.
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

  /// Validates if the specified memory ID belongs to a given user.
  ///
  /// This method queries the "Memory" table to check if a memory with the given ID exists and belongs
  /// to the provided user ID.
  ///
  /// [memoryId] - The memory ID to check.
  /// [creatorId] - The user ID to validate the memory against.
  ///
  /// Returns `true` if the memory ID does not belong to the specified user, otherwise `false`.
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
