import 'package:roadsyouwalked_app/model/assessment/mood_evaluation.dart';

class MoodEvaluationHelper {  // TODO: make singleton
  Map<String, int> calculareResultsFromScores(final Map<MoodEvaluationItem, int?> scores) {
    if (scores.keys.any((item) => item.affectType == null)) {
      return {
        "total": scores.values.fold(0, (totalScore, score) => totalScore + score!)
      };
    } else {
      Map<String, int> result = {};
      for (var entry in scores.entries) {
        final String key = entry.key.affectType!.value;
        final int value = entry.value ?? 0;
        result.update(key, (v) => v + value, ifAbsent: () => value);
      }
      return result;
    }
  }
}