import 'package:roadsyouwalked_app/model/media/media.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';

/// Interface for saving media to a persistent storage.
abstract class IMediaStorageService {
  /// Saves media from a pending state to a persistent storage location.
  ///
  /// [pendingMedia] - The [PendingMedia] object that contains the media data to be saved.
  ///
  /// Returns a [Media] object containing the relevant media data, including the source type and reference.
  Future<Media> saveMedia(final PendingMedia pendingMedia);
}