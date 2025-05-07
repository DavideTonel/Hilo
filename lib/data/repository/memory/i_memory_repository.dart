import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';
import 'package:roadsyouwalked_app/model/memory/memory.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_data.dart';

/// Interface for managing memory-related data.
abstract class IMemoryRepository {
  /// Retrieves a list of memories for a given user ID.
  ///
  /// [userId] - The ID of the user whose memories are to be retrieved.
  ///
  /// Returns a list of `Memory` objects.
  Future<List<Memory>> getMemoriesByUserId(final String userId);

  /// Retrieves a list of memories for a given user ID from a specific date.
  ///
  /// [userId] - The ID of the user whose memories are to be retrieved.
  /// [fromDate] - The starting date for fetching memories.
  ///
  /// Returns a list of `Memory` objects.
  Future<List<Memory>> getMemoriesByUserIdFromDate(
    final String userId,
    final DateTime fromDate,
  );

  /// Retrieves a list of memories for a given user ID and a specific year and month.
  ///
  /// [userId] - The ID of the user whose memories are to be retrieved.
  /// [year] - The year for which memories are to be fetched.
  /// [month] - The month for which memories are to be fetched.
  ///
  /// Returns a list of `Memory` objects.
  Future<List<Memory>> getMemoriesByUserIdAndTime(
    final String userId,
    final int year,
    final int month,
  );

  /// Retrieves a list of memories for a given user ID in a specific year.
  ///
  /// [userId] - The ID of the user whose memories are to be retrieved.
  /// [year] - The year for which memories are to be fetched.
  ///
  /// Returns a list of `Memory` objects.
  Future<List<Memory>> getMemoriesByUserIdInYear(
    final String userId,
    final int year,
  );

  /// Saves a new memory along with its associated media and evaluation result items.
  ///
  /// This method saves a memory along with its data.
  /// It ensures that all related information is stored atomically.
  ///
  /// [memoryData] - The `MemoryData` object containing the memory details to be saved.
  /// [pendingMediaList] - A list of `PendingMedia` objects representing the media to be saved.
  /// [evaluationSingleItemScores] - A list of `EvaluationResultItem` objects representing the evaluation scores.
  Future<void> saveMemory(
    MemoryData memoryData,
    List<PendingMedia> pendingMediaList,
    List<EvaluationResultItem> evaluationSingleItemScores,
  );
}
