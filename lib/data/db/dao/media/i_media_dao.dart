import 'package:roadsyouwalked_app/model/media/media.dart';
import 'package:sqflite/sqflite.dart';

/// Interface for accessing media stored in the database.
abstract class IMediaDao {
  /// Inserts a new media record into the database.
  ///
  /// [media] - The `Media` object to be inserted into the database.
  /// [transaction] - An optional database transaction to be used for the insert operation.
  ///
  /// Returns the ID of the inserted media if successful, otherwise `null`.
  Future<String?> insertMedia(final Media media, final Transaction? transaction);

  /// Retrieves a media record by its ID.
  ///
  /// [id] - The ID of the media record to be retrieved.
  ///
  /// Returns the `Media` object associated with the provided ID, or `null` if no record is found.
  Future<Media?> getMediaById(final String id);

  /// Retrieves all media associated with a specific memory ID and creator ID.
  ///
  /// [memoryId] - The memory ID whose media records are to be retrieved.
  /// [creatorId] - The creator ID whose media records are to be retrieved.
  ///
  /// Returns a list of `Media` objects associated with the provided memory and creator IDs.
  Future<List<Media>> getMediaByMemoryId(final String memoryId, final String creatorId);

  /// Validates if a specified media ID exists in the database.
  ///
  /// [id] - The media ID to check.
  ///
  /// Returns `true` if the media ID does not exist, otherwise `false`.
  Future<bool> isValidId(final String id);
}
