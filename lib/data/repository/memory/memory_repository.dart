import 'package:roadsyouwalked_app/data/db/dao/media/i_media_dao.dart';
import 'package:roadsyouwalked_app/data/db/dao/media/media_dao.dart';
import 'package:roadsyouwalked_app/data/db/dao/memory/i_memory_dao.dart';
import 'package:roadsyouwalked_app/data/db/dao/memory/memory_dao.dart';
import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/data/repository/evaluation/evaluation_repository.dart';
import 'package:roadsyouwalked_app/data/repository/evaluation/i_evaluation_repository.dart';
import 'package:roadsyouwalked_app/data/repository/memory/i_memory_repository.dart';
import 'package:roadsyouwalked_app/data/storage/i_media_storage_service.dart';
import 'package:roadsyouwalked_app/data/storage/media_storage_service.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';
import 'package:roadsyouwalked_app/model/media/media.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

import 'dart:developer' as dev;

/// A repository class for managing memory-related data.
/// A concrete implementation of [IMemoryRepository].
class MemoryRepository extends IMemoryRepository {
  final IMemoryDao _memoryDao = MemoryDao();
  final IMediaDao _mediaDao = MediaDao();
  final IMediaStorageService _mediaStorageService = MediaStorageService();
  final IEvaluationRepository _evaluationRepository = EvaluationRepository();

  @override
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

  @override
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

  @override
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

  @override
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

  @override
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
