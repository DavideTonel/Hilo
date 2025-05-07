import 'package:roadsyouwalked_app/data/db/dao/media_dao.dart';
import 'package:roadsyouwalked_app/data/db/dao/memory_dao.dart';
import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/data/repository/evaluation_repository.dart';
import 'package:roadsyouwalked_app/data/storage/media_storage_service.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';
import 'package:roadsyouwalked_app/model/media/media.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

import 'dart:developer' as dev;

/// A repository class for managing memory-related data.
class MemoryRepository {
  final _memoryDao = MemoryDao();
  final _mediaDao = MediaDao();
  final _mediaStorageService = MediaStorageService();
  final _evaluationRepository = EvaluationRepository();

  /// Retrieves a list of memories for a given user ID.
  ///
  /// This method gets the memories and associates the corresponding
  /// media files with each memory.
  ///
  /// [userId] - The ID of the user whose memories are to be retrieved.
  ///
  /// Returns a list of `Memory` objects with their associated media.
  Future<List<Memory>> getMemoriesByUserId(final String userId) async {
    List<Memory> memories = await _memoryDao.getMemoriesByUserId(userId);
    for (var memory in memories) {
      List<Media> mediaList = await _mediaDao.getMediaByMemoryId(
        memory.data.core.id,
        memory.data.core.creatorId,
      );
      memory.mediaList = mediaList;
    }
    return memories;
  }

  /// Retrieves a list of memories for a given user ID from a specific date.
  ///
  /// This method fetches memories starting from a particular
  /// date and associates the corresponding media files with each memory.
  ///
  /// [userId] - The ID of the user whose memories are to be retrieved.
  /// [fromDate] - The starting date for fetching memories.
  ///
  /// Returns a list of `Memory` objects with their associated media.
  Future<List<Memory>> getMemoriesByUserIdFromDate(
    final String userId,
    final DateTime fromDate,
  ) async {
    List<Memory> memories = await _memoryDao.getMemoriesByUserIdFromDate(
      userId,
      fromDate,
    );
    for (var memory in memories) {
      List<Media> mediaList = await _mediaDao.getMediaByMemoryId(
        memory.data.core.id,
        memory.data.core.creatorId,
      );
      memory.mediaList = mediaList;
    }
    return memories;
  }

  /// Retrieves a list of memories for a given user ID and a specific year and month.
  ///
  /// This method fetches memories for a specific month and year
  /// and associates the corresponding media files with each memory.
  ///
  /// [userId] - The ID of the user whose memories are to be retrieved.
  /// [year] - The year for which memories are to be fetched.
  /// [month] - The month for which memories are to be fetched.
  ///
  /// Returns a list of `Memory` objects with their associated media.
  Future<List<Memory>> getMemoriesByUserIdAndTime(
    final String userId,
    final int year,
    final int month,
  ) async {
    final String monthString = month.toString().padLeft(2, "0");
    final String yearString = year.toString();

    List<Memory> memories = await _memoryDao.getMemoriesByUserIdAndTime(
      userId,
      yearString,
      monthString,
    );
    for (var memory in memories) {
      List<Media> mediaList = await _mediaDao.getMediaByMemoryId(
        memory.data.core.id,
        memory.data.core.creatorId,
      );
      memory.mediaList = mediaList;
    }
    return memories;
  }

  /// Retrieves a list of memories for a given user ID in a specific year.
  ///
  /// This method fetches memories for a specific year
  /// and associates the corresponding media files with each memory.
  ///
  /// [userId] - The ID of the user whose memories are to be retrieved.
  /// [year] - The year for which memories are to be fetched.
  ///
  /// Returns a list of `Memory` objects with their associated media.
  Future<List<Memory>> getMemoriesByUserIdInYear(
    final String userId,
    final int year,
  ) async {
    final String yearString = year.toString();

    List<Memory> memories = await _memoryDao.getMemoriesByUserIdInYear(
      userId,
      yearString,
    );
    for (var memory in memories) {
      List<Media> mediaList = await _mediaDao.getMediaByMemoryId(
        memory.data.core.id,
        memory.data.core.creatorId,
      );
      memory.mediaList = mediaList;
    }
    return memories;
  }

  /// Saves a new memory along with its associated media and evaluation result items.
  ///
  /// This method saves a memory along with its data.
  /// It ensures that all related information is stored atomically.
  ///
  /// [memoryData] - The `MemoryData` object containing the memory details to be saved.
  /// [pendingMediaList] - A list of `PendingMedia` objects representing the media to be saved.
  /// [evaluationSingleItemScores] - A list of `EvaluationResultItem` objects representing the evaluation scores.
  Future<void> saveMemory(
    MemoryData memoryData,
    List<PendingMedia> pendingMediaList,
    List<EvaluationResultItem> evaluationSingleItemScores,
  ) async {
    await DatabaseManager.instance.database.then((db) {
      db.transaction((transaction) async {
        try {
          _memoryDao.insertMemory(Memory(data: memoryData), transaction);

          for (var pendingMedia in pendingMediaList) {
            final Media media = await _mediaStorageService.saveMedia(
              pendingMedia,
            );
            await _mediaDao.insertMedia(media, transaction);
          }
          
          await _evaluationRepository.saveEvaluationItemScores(
            memoryData.core.id,
            memoryData.core.creatorId,
            memoryData.evaluation.evaluationScaleId,
            evaluationSingleItemScores,
            transaction,
          );
        } catch (e) {
          dev.log(e.toString());
          rethrow;
        }
      });
    });
  }
}
