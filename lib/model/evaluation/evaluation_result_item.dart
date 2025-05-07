/// Represents the score for an individual item in an evaluation scale.
///
/// This class stores the result for each item within a scale, including the
/// item identifier and the score assigned to that item. It is typically used
/// to hold responses to individual questions or subscales in a broader evaluation.
class EvaluationResultItem {
  /// The identifier of the evaluation scale item (e.g., a specific question or subscale).
  final String evaluationScaleItemId;

  /// The score assigned to this specific evaluation scale item.
  final int score;

  /// Creates an [EvaluationResultItem] instance with the provided item ID and score.
  EvaluationResultItem({
    required this.evaluationScaleItemId,
    required this.score,
  });

  /// Converts the [EvaluationResultItem] into a map for serialization purposes.
  ///
  /// This method is typically used to convert the instance into a format
  /// suitable for storage or communication (e.g., database, API).
  Map<String, dynamic> toMap() {
    return {
      "evaluationScaleItemId": evaluationScaleItemId,
      "score": score,
    };
  }

  /// Creates an [EvaluationResultItem] instance from a map.
  ///
  /// This factory constructor is typically used to deserialize data from
  /// storage or external sources (e.g., a database or API response).
  factory EvaluationResultItem.fromMap(Map<String, dynamic> map) {
    return EvaluationResultItem(
      evaluationScaleItemId: map["evaluationScaleItemId"] as String,
      score: map["score"] as int,
    );
  }
}
