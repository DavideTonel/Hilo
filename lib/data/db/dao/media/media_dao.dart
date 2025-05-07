import 'package:roadsyouwalked_app/data/db/dao/media/i_media_dao.dart';
import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/media/media.dart';

import 'dart:developer' as dev;

import 'package:sqflite/sqflite.dart';

/// Data Access Object (DAO) class for managing media-related operations in the database.
/// /// Concrete implementation of [IMediaDao]
class MediaDao extends IMediaDao {
  // Instance of the DatabaseManager for accessing the database.
  final DatabaseManager _dbManager = DatabaseManager.instance;

  @override
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

  @override
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

  @override
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

  @override
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
