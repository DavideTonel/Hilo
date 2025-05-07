import 'package:roadsyouwalked_app/model/media/media_source_type.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';

/// A class representing a media item, such as an image, video, audio, or document.
///
/// This class encapsulates the details of a media item.
class Media {
  /// The unique identifier of the media item.
  final String id;

  /// The ID of the memory associated with this media item, if any.
  final String? memoryid;

  /// The ID of the creator of this media item, if available.
  final String? creatorId;

  /// The source type of the media (e.g., local, remote, cloud).
  final MediaSourceType sourceType;

  /// The type of the media (e.g., image, video, audio).
  final MediaType type;

  /// The reference (URL or file path) to the media.
  final String reference;

  /// Constructor for creating a [Media] instance.
  ///
  /// The [id], [sourceType], [type], and [reference] are required parameters.
  /// The [memoryid] and [creatorId] are optional.
  Media({
    required this.id,
    this.memoryid,
    this.creatorId,
    required this.sourceType,
    required this.type,
    required this.reference,
  });

  /// Converts the [Media] instance to a map for storage or serialization.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "memoryId": memoryid,
      "creatorId": creatorId,
      "sourceType": sourceType.value,
      "type": type.value,
      "reference": reference,
    };
  }

  /// Factory method to create a [Media] instance from a map.
  ///
  /// This method converts a map of key-value pairs into a [Media] object.
  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      id: map["id"] as String,
      memoryid: map["memoryId"] as String?,
      creatorId: map["creatorId"] as String?,
      sourceType: MediaSourceType.fromString(map["sourceType"] as String),
      type: MediaType.fromString(map["type"] as String),
      reference: map["reference"] as String,
    );
  }
}
