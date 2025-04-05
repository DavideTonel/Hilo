import 'dart:io';

import 'package:roadsyouwalked_app/model/media/media_type.dart';

class PendingMedia {
  final String id;
  final MediaType type;
  final File? localFile;
  final String? remoteUri;
  final String? memoryId;
  final String? creatorId;

  PendingMedia(
    {
      required this.id,
      required this.type,
      this.localFile,
      this.remoteUri,
      this.memoryId,
      this.creatorId
    }
  );
}
