import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:sqflite/sqflite.dart';

abstract class IMemoryDao {
  /// Retrieves all memories associated with a specific user.
  ///
  /// [userId] - The user ID whose memories are to be retrieved.
  ///
  /// Returns a list of `Memory` objects associated with the provided user ID, ordered by timestamp in descending order.
  Future<List<Memory>> getMemoriesByUserId(final String userId);

  /// Retrieves memories for a user starting from a specific date.
  ///
  /// [userId] - The user ID whose memories are to be retrieved.
  /// [fromDate] - The start date to filter memories from.
  ///
  /// Returns a list of `Memory` objects that are associated with the provided user ID and have a timestamp greater than or equal to the provided date.
  Future<List<Memory>> getMemoriesByUserIdFromDate(final String userId, final DateTime fromDate);

  /// Retrieves memories for a user within a specific month and year.
  ///
  /// [userId] - The user ID whose memories are to be retrieved.
  /// [year] - The year to filter memories by.
  /// [month] - The month to filter memories by.
  ///
  /// Returns a list of `Memory` objects associated with the provided user ID, year, and month, ordered by timestamp in ascending order.
  Future<List<Memory>> getMemoriesByUserIdAndTime(final String userId, final String year, final String month);

  /// Retrieves memories for a user within a specific year.
  ///
  /// [userId] - The user ID whose memories are to be retrieved.
  /// [year] - The year to filter memories by.
  ///
  /// Returns a list of `Memory` objects associated with the provided user ID and year, ordered by timestamp in ascending order.
  Future<List<Memory>> getMemoriesByUserIdInYear(final String userId, final String year);

  /// Inserts a new memory into the database.
  ///
  /// [memory] - The `Memory` object to be inserted into the database.
  /// [transaction] - An optional database transaction to be used for the insert operation.
  ///
  /// Returns `true` if the memory was successfully inserted, otherwise `false`.
  Future<bool> insertMemory(final Memory memory, Transaction? transaction);

  /// Validates if the specified memory ID belongs to a given user.
  ///
  /// [memoryId] - The memory ID to check.
  /// [creatorId] - The user ID to validate the memory against.
  ///
  /// Returns `true` if the memory ID does not belong to the specified user, otherwise `false`.
  Future<bool> isValidId(final String memoryId, final String creatorId);
}