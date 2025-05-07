import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/media/media.dart';

import 'dart:developer' as dev;

import 'package:sqflite/sqflite.dart';

/// Data Access Object (DAO) class for managing media-related operations in the database.
class MediaDao {
  // Instance of the DatabaseManager for accessing the database.
  final DatabaseManager _dbManager = DatabaseManager.instance;

  /// Inserts a new media record into the database.
  ///
  /// This method inserts a new media entry into the "Media" table.
  ///
  /// [media] - The `Media` object to be inserted into the database.
  /// [transaction] - An optional database transaction to be used for the insert operation.
  ///
  /// Returns the ID of the inserted media if successful, otherwise `null`.
  Future<String?> insertMedia(final Media media, final Transaction? transaction) async {
    try {
      final controller = transaction ?? await _dbManager.database;
      await controller.insert(
        "Media",
        media.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort
      );
      return media.id;
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  /// Retrieves a media record by its ID.
  ///
  /// This method queries the "Media" table to fetch a media record with the given ID.
  ///
  /// [id] - The ID of the media record to be retrieved.
  ///
  /// Returns the `Media` object associated with the provided ID, or `null` if no record is found.
  Future<Media?> getMediaById(final String id) async {
    try {
      final db = await _dbManager.database;
      return await db.query(
        "Media",
        where: "id = ?",
        whereArgs: [ id ],
        limit: 1
      ).then((results) {
        if (results.isNotEmpty) {
          final result = results.first;
          return Media.fromMap(result);
        } else {
          return null;
        }
      });
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  /// Retrieves all media associated with a specific memory ID and creator ID.
  ///
  /// This method queries the "Media" table to fetch all media records linked to a specific memory ID and creator ID.
  ///
  /// [memoryId] - The memory ID whose media records are to be retrieved.
  /// [creatorId] - The creator ID whose media records are to be retrieved.
  ///
  /// Returns a list of `Media` objects associated with the provided memory and creator IDs.
  Future<List<Media>> getMediaByMemoryId(final String memoryId, final String creatorId) async {
    try {
      final db = await _dbManager.database;
      return await db.query(
        "Media",
        where: "memoryId = ? AND creatorId = ?",
        whereArgs: [ memoryId, creatorId ],
      ).then((res) => res.map((map) => Media.fromMap(map)).toList());
    } catch (e) {
      dev.log(e.toString());
      return [];
    }
  }

  /// Validates if a specified media ID exists in the database.
  ///
  /// This method queries the "Media" table to check if a media record with the given ID exists.
  ///
  /// [id] - The media ID to check.
  ///
  /// Returns `true` if the media ID does not exist, otherwise `false`.
  Future<bool> isValidId(final String id) async {
    try {
      final db = await _dbManager.database;
      return await db.query(
        "Media",
        where: "id = ?",
        whereArgs: [id]
      ).then((res) => res.isEmpty);
    } catch (e) {
      dev.log(e.toString());
      return false;
    }
  }
}
