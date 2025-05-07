import 'package:roadsyouwalked_app/model/memory/memory_data/memory_core_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_evaluation_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_position_data.dart';

/// A class representing all the data associated with a memory.
///
/// It serves as a comprehensive representation of a memory in the application.
class MemoryData {
  /// The core data of the memory (e.g., ID, creator, timestamp).
  final MemoryCoreData core;

  /// The evaluation data of the memory (e.g., user ratings or mood evaluation).
  final MemoryEvaluationData evaluation;

  /// The position data of the memory (e.g., geographical or spatial information).
  /// This is optional and may not be present for all memories.
  final MemoryPositionData? position;

  /// Constructor for creating a [MemoryData] object.
  ///
  /// Parameters:
  /// - [core]: The core data of the memory.
  /// - [evaluation]: The evaluation data of the memory.
  /// - [position]: The optional position data of the memory.
  MemoryData({
    required this.core,
    required this.evaluation,
    this.position,
  });

  /// Converts the [MemoryData] object into a map.
  ///
  /// This method is useful for converting the object into a format that can be stored, transmitted,
  /// or used for serialization (e.g., for database storage or API responses).
  ///
  /// Returns a map containing the core, evaluation, and position data.
  Map<String, dynamic> toMap() {
    return {
      ...core.toMap(),
      ...evaluation.toMap(),
      ...?position?.toMap(),
    };
  }

  /// Creates a [MemoryData] object from a map.
  ///
  /// This factory constructor is used to create a [MemoryData] object from a map, typically
  /// retrieved from a database, API, or other sources.
  ///
  /// Parameters:
  /// - [map]: The map containing the memory's data.
  ///
  /// Returns a [MemoryData] object created from the map.
  factory MemoryData.fromMap(Map<String, dynamic> map) {
    return MemoryData(
      core: MemoryCoreData.fromMap(map),
      evaluation: MemoryEvaluationData.fromMap(map),
      position: MemoryPositionData.fromMap(map),
    );
  }
}
