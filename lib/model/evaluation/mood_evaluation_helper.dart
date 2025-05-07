import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale_item.dart';

/// A utility class designed to assist with the calculation of evaluation results
/// from user scores based on different evaluation scale items. This helper class
/// computes the total score or categorizes the score based on the affect type.
///
/// This class implements the Singleton design pattern, ensuring that only one instance
/// of the helper exists throughout the application.
class EvaluationHelper {
  /// The singleton instance of [EvaluationHelper].
  static final EvaluationHelper _instance = EvaluationHelper._internal();

  /// Private constructor to prevent external instantiation of the class.
  EvaluationHelper._internal();

  /// Provides access to the singleton instance of [EvaluationHelper].
  factory EvaluationHelper() => _instance;

  /// Calculates results based on the scores provided for each evaluation scale item.
  ///
  /// The method calculates the total score, and if the affect type is not null,
  /// it separates the scores into different categories (e.g., positive or negative).
  /// The results are returned in a map where the key is the affect type value
  /// (e.g., "positive", "negative"), and the value is the aggregated score for that category.
  ///
  /// If the affect type is `null` for any item, all scores are aggregated into a total score.
  ///
  /// [scores] is a map where the keys are [EvaluationScaleItem] objects and the values
  /// are the corresponding scores for each item.
  ///
  /// Returns a [Map<String, double>] containing the calculated results.
  Map<String, double> calculareResultsFromScores(final Map<EvaluationScaleItem, int?> scores) {
    // If any item has a null affectType, sum all the scores into a total score.
    if (scores.keys.any((item) => item.affectType == null)) {
      return {
        "total": scores.values.fold(0, (totalScore, score) => totalScore + score!)
      };
    } else {
      Map<String, double> result = {};
      for (var entry in scores.entries) {
        final String key = entry.key.affectType!.value;
        final double value = (entry.value ?? 0).toDouble();
        result.update(key, (v) => v + value, ifAbsent: () => value);
      }
      return result;
    }
  }
}
