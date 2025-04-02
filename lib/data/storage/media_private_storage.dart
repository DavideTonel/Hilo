import 'dart:io';
import 'dart:typed_data';

import 'package:roadsyouwalked_app/data/storage/private_storage.dart';

class MediaPrivateStorage extends PrivateStorage {
  Future<List<File>> getMedia(final List<String> path) {
    path.add("media");
    return super.getFilesInDirectory(path);
  }

  Future<bool> saveMedia(String name, final List<String> path, Uint8List data) {
    path.add("media");
    return super.saveFile(name, path, data);
  }
}

class MemoryMediaManager {
  MediaPrivateStorage mediaStorage = MediaPrivateStorage();

  Future<List<File>> getMediaByUserId(final String id) async {
    return await mediaStorage.getMedia([ id ]);
  }

  Future<bool> saveMedia(final String idCreator, final String mediaName, final Uint8List data) {
    return mediaStorage.saveFile(
      mediaName,
      [ idCreator ],
      data
    );
  }
}
