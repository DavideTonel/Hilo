import 'package:roadsyouwalked_app/model/media/media_source_type.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';

class Media {
  final String id;
  final String? memoryid;
  final String? creatorId;
  final MediaSourceType sourceType;
  final MediaType type;
  final String reference;

  Media(
    {
      required this.id,
      this.memoryid,
      this.creatorId,
      required this.sourceType,
      required this.type,
      required this.reference
    }
  );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "memoryId": memoryid,
      "creatorId": creatorId,
      "sourceType": sourceType.value,
      "type": type.value,
      "reference": reference
    };
  }

  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      id: map["id"] as String,
      memoryid: map["memoryId"] as String?,
      creatorId: map["creatorId"] as String?,
      sourceType: MediaSourceType.fromString(map["sourceType"] as String),
      type: MediaType.fromString(map["type"] as String),
      reference: map["reference"] as String
    );
  }
}
