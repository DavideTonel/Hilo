import 'package:roadsyouwalked_app/data/db/dao/memory_dao.dart';
import 'package:roadsyouwalked_app/data/storage/media_private_storage.dart';
import 'package:roadsyouwalked_app/model/memory/data/memory_data.dart';
import 'package:roadsyouwalked_app/model/memory/data/memory_media_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';

class MemoryRepository {
  final _memoryDao = MemoryDao();
  final _memoryMediaManager = MemoryMediaManager();

  Future<List<Memory>> getMemoriesByUserId(final String userId) async {
    // no need to retrieve all the files
    // just, when want to display the media, get the base directory path / username / media path / memoryId
    // ...

    return await _memoryDao.getMemoriesByUserId(userId);
  }

  Future<bool> saveMemory(MemoryData memoryData, MemoryMediaData memoryMediaData) async {
    final creatorId = memoryData.basic.creatorId;
    final timestamp = memoryData.basic.timestamp;
    final memoryId = "${creatorId}_$timestamp";
    // TODO check both save media and save memory end successfully (could create a OperationResult)
    bool mediaSaved = await _memoryMediaManager.saveMedia(
      creatorId,
      memoryId,
      memoryMediaData.data
    );
    bool memorySaved = await _memoryDao.saveMemory(
      Memory(
        id: memoryId,
        data: memoryData
      )
    );
    return mediaSaved && memorySaved;
  }
}
