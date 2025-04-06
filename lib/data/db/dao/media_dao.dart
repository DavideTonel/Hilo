import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/media/media.dart';

import 'dart:developer' as dev;

import 'package:sqflite/sqflite.dart';

class MediaDao {
  final DatabaseManager _dbManager = DatabaseManager.instance;

  Future<String?> insertMedia(final Media media, final Transaction? transaction) async {
    dev.log("media source type: ${media.sourceType.value}");
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
