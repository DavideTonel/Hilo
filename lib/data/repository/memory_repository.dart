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

class MemoryRepository {
  final _memoryDao = MemoryDao();
  final _mediaDao = MediaDao();
  final _mediaStorageService = MediaStorageService();
  final _evaluationRepository = EvaluationRepository();

  Future<List<Memory>> getMemoriesByUserId(final String userId) async {
    // #1 get memories
    List<Memory> memories = await _memoryDao.getMemoriesByUserId(userId);
    for (var memory in memories) {
      // #2 get mediaList for each memory
      List<Media> mediaList = await _mediaDao.getMediaByMemoryId(
        memory.data.core.id,
        memory.data.core.creatorId,
      );
      // #3 add mediaList to memory
      memory.mediaList = mediaList;
    }
    return memories;
  }

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

  Future<List<Memory>> getMemoriesByUserIdInYear(
    final String userId,
    final int year,
  ) async {
    final String yearString = year.toString();

    List<Memory> memories = await _memoryDao.getMemoriesByUserIdInYear(
      userId,
      yearString
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
