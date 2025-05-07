import 'dart:io';

import 'package:roadsyouwalked_app/data/storage/private_storage.dart';
import 'package:roadsyouwalked_app/model/media/media.dart';
import 'package:roadsyouwalked_app/model/media/media_source_type.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';

/// A service class responsible for managing media storage operations.
class MediaStorageService {
  // Private instance of [PrivateStorage] to handle file saving operations.
  final PrivateStorage _privateStorage = PrivateStorage();

  /// Constructor for the [MediaStorageService].
  MediaStorageService();

  /// Saves media from a pending state to a persistent storage location.
  ///
  /// This method determines whether the media file is local or remote. If the file is local,
  /// it will be saved to the private storage of the application. If it is remote, it stores the
  /// URI reference.
  ///
  /// [pendingMedia] - The [PendingMedia] object that contains the media data to be saved.
  ///
  /// Returns a [Media] object containing the relevant media data, including the source type and reference.
  ///
  /// Throws an exception if neither [localFile] nor [remoteUri] is provided in [pendingMedia].
  Future<Media> saveMedia(final PendingMedia pendingMedia) async {
    MediaSourceType sourceType;
    String reference;

    if (pendingMedia.localFile != null) {
      sourceType = MediaSourceType.local;
      reference = await _saveFileToPrivateStorage(
        pendingMedia.id,
        pendingMedia.localFile!,
        pendingMedia.creatorId ?? "system", // Use 'system' as default creatorId if not provided
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

  /// Private helper method that saves a local media file to the app's private storage.
  ///
  /// This method handles saving local media files to a specific directory structure, based on the
  /// creator's ID and the media type (e.g., images, videos, etc.). It returns the file path as a string.
  ///
  /// [id] - The unique identifier for the media.
  /// [file] - The [File] object representing the local media to be saved.
  /// [creatorId] - The creator's ID associated with the media, used to organize the directory structure.
  /// [mediaType] - The type of media (e.g., image, video) to determine where to store the file.
  ///
  /// Returns the file path where the media has been saved.
  Future<String> _saveFileToPrivateStorage(String id, File file, String creatorId, MediaType mediaType) async {
    final List<String> additionalSegments = [
      creatorId,
      "media",
      mediaType.value
    ];
    return await _privateStorage.saveFile(id, file, additionalSegments: additionalSegments);
  }
}
