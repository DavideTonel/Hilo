import 'package:roadsyouwalked_app/data/db/dao/media_dao.dart';
import 'package:roadsyouwalked_app/data/db/dao/memory_dao.dart';
import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/data/storage/media_storage_service.dart';
import 'package:roadsyouwalked_app/model/media/media.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

import 'dart:developer' as dev;

class MemoryRepository {
  final _memoryDao = MemoryDao();
  final _mediaDao = MediaDao();
  final _mediaStorageService = MediaStorageService();

  Future<List<Memory>> getMemoriesByUserId(final String userId) async {
    // #1 get memories
    List<Memory> memories = await _memoryDao.getMemoriesByUserId(userId);
    for (var memory in memories) {
      // #2 get mediaList for each memory
      List<Media> mediaList = await _mediaDao.getMediaByMemoryId(memory.data.core.id, memory.data.core.creatorId);
      // #3 add mediaList to memory
      memory.mediaList = mediaList;
      dev.log('memory: ${memory.data.core.id}\tmediaList: ${mediaList.length}');
    }
    return memories;
  }

  Future<void> saveMemory(MemoryData memoryData, List<PendingMedia> pendingMediaList) async {
    //final creatorId = memoryData.core.creatorId;
    //final timestamp = memoryData.core.timestamp;
    //final memoryId = "${creatorId}_$timestamp";

    await DatabaseManager.instance.database.then((db) {
      // #0 start transaction
      db.transaction((transaction) async {
        try {
          // #1 save memory
          _memoryDao.insertMemory(
            Memory(
              data: memoryData
            ),
            transaction
          );

          for (var pendingMedia in pendingMediaList) {
            // #2 save media in the media storage and save it in the database
            final Media media = await _mediaStorageService.saveMedia(pendingMedia);

            // #3 save media in the database
            //if (media.reference != null) {
            await _mediaDao.insertMedia(media, transaction);
            //} else {
              //throw Exception("Error saving media: ${media.id}");
            //}
          }
          //dev.log("Memory and media saved successfully");
        } catch (e) {
          // # 0 roll back transaction
          dev.log(e.toString());
          rethrow;
        }
      });
    });
  }
}
