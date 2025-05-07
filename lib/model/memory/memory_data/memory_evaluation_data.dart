import 'dart:convert';

/// A class that holds the evaluation data for a memory.
class MemoryEvaluationData {
  /// The ID of the evaluation scale used for this memory's evaluation.
  final String evaluationScaleId;

  /// A map representing the results of the evaluation.
  /// The keys are evaluation item IDs (e.g., specific aspects or questions in the scale),
  /// and the values are the numerical scores for those items.
  final Map<String, double> evaluationResult;

  /// Constructor for creating a [MemoryEvaluationData] object.
  ///
  /// Parameters:
  /// - [evaluationScaleId]: The ID of the evaluation scale used for this memory's evaluation.
  /// - [evaluationResult]: A map of evaluation items and their respective scores.
  MemoryEvaluationData({
    required this.evaluationScaleId,
    required this.evaluationResult,
  });

  /// Creates a [MemoryEvaluationData] object from a map.
  ///
  /// This factory constructor is used to create a [MemoryEvaluationData] object from a map,
  /// typically retrieved from a database or API. The evaluation results are stored as a JSON-encoded string.
  ///
  /// Parameters:
  /// - [map]: A map containing the memory's evaluation data.
  ///
  /// Returns a [MemoryEvaluationData] object created from the map.
  factory MemoryEvaluationData.fromMap(final Map<String, dynamic> map) {
    return MemoryEvaluationData(
      evaluationScaleId: map["evaluationScaleId"] as String,
      // Decode the JSON string into a Map<String, double>
      evaluationResult: (json.decode(map["resultJson"]) as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, (value as num).toDouble())),
    );
  }

  /// Converts the [MemoryEvaluationData] object into a map.
  ///
  /// This method is used to serialize the evaluation data for storage or transmission.
  /// The evaluation result map is encoded as a JSON string for easier storage.
  ///
  /// Returns a map representing the memory's evaluation data, ready for serialization.
  Map<String, dynamic> toMap() {
    return {
      "evaluationScaleId": evaluationScaleId,
      "resultJson": json.encode(evaluationResult),
    };
  }
}
