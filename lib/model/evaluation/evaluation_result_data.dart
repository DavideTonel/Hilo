import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';

/// Represents the result of an evaluation for a specific scale, including both
/// overall scores and individual item scores.
///
/// This class is typically used to store the outcome of a mood or
/// psychological evaluation.
///
/// [evaluationScaleId] uniquely identifies the scale used for the evaluation.
/// [result] contains aggregated or computed scores, where each key represents a score label
/// (e.g., "positive", "negative") and its corresponding value.
/// [singleItemScores] contains the individual scores for each item/question within the scale.
class EvaluationResultData {
  /// The identifier of the evaluation scale used.
  final String evaluationScaleId;

  /// A map of computed result labels to their numeric values (e.g., {"positive": 3.5}).
  final Map<String, double> result;

  /// A list of results for each individual item in the evaluation.
  final List<EvaluationResultItem> singleItemScores;

  /// Creates an [EvaluationResultData] instance with the provided scale ID,
  /// result map, and list of item-level scores.
  EvaluationResultData({
    required this.evaluationScaleId,
    required this.result,
    required this.singleItemScores,
  });
}
