import 'dart:io';

import 'package:roadsyouwalked_app/data/storage/private_storage.dart';
import 'package:roadsyouwalked_app/model/media/media.dart';
import 'package:roadsyouwalked_app/model/media/media_source_type.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';

class MediaStorageService {
  final PrivatStorage _privateStorage = PrivatStorage();

  MediaStorageService();

  Future<Media> saveMedia(final PendingMedia pendingMedia) async {
    MediaSourceType sourceType;
    String reference;

    if (pendingMedia.localFile != null) {
      sourceType = MediaSourceType.local;
      reference = await _saveFileToPrivateStorage(
        pendingMedia.id,
        pendingMedia.localFile!,
        pendingMedia.creatorId ?? "system",
        pendingMedia.type
      );
    } else if (pendingMedia.remoteUri != null) {
      sourceType = MediaSourceType.remote;
      reference = pendingMedia.remoteUri!;
    } else {
      throw Exception("Either localFile or remoteUri must be provided");
    }
    return Media(
      id: pendingMedia.id,
      memoryid: pendingMedia.memoryId,
      creatorId: pendingMedia.creatorId,
      sourceType: sourceType,
      type: pendingMedia.type,
      reference: reference
    );
  }

  Future<String> _saveFileToPrivateStorage(String id, File file, String creatorId, MediaType mediaType) async {
    final List<String> additionalSegments = [
      creatorId,
      "media",
      mediaType.value
    ];
    return await _privateStorage.saveFile(id, file, additionalSegments: additionalSegments);
  }
}
