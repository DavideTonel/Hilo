import 'dart:io';
import 'package:roadsyouwalked_app/model/media/media_type.dart';

/// A class representing media that is pending for upload or processing.
///
/// This class is used to store information about media files (image, video, audio, etc.) 
/// that are in a pending state, meaning they are either not yet uploaded or processed. 
/// It holds the relevant data to identify and process the media item.
class PendingMedia {
  /// A unique identifier for the pending media.
  final String id;

  /// The type of media (e.g., image, video, audio, etc.).
  final MediaType type;

  /// The local file associated with the media (if any).
  /// This is used when the media is stored locally before being uploaded.
  final File? localFile;

  /// The remote URI associated with the media (if any).
  /// This is used when the media has a remote location, but not yet available locally.
  final String? remoteUri;

  /// The ID of the memory that this media is associated with (if any).
  /// This links the media to a specific memory in the app.
  final String? memoryId;

  /// The ID of the creator of the media (if any).
  /// This represents the person who uploaded or created the media item.
  final String? creatorId;

  /// Constructor for creating a `PendingMedia` object.
  ///
  /// Parameters:
  /// - [id]: The unique identifier for the media.
  /// - [type]: The type of the media (image, video, audio, etc.).
  /// - [localFile]: The local file associated with the media (optional).
  /// - [remoteUri]: The remote URI associated with the media (optional).
  /// - [memoryId]: The memory ID associated with the media (optional).
  /// - [creatorId]: The creator ID associated with the media (optional).
  PendingMedia({
    required this.id,
    required this.type,
    this.localFile,
    this.remoteUri,
    this.memoryId,
    this.creatorId,
  });
}
