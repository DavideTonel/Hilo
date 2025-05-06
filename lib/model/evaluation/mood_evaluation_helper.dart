import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale_item.dart';

class EvaluationHelper {
  static final EvaluationHelper _instance = EvaluationHelper._internal();

  EvaluationHelper._internal();

  factory EvaluationHelper() => _instance;

  Map<String, double> calculareResultsFromScores(final Map<EvaluationScaleItem, int?> scores) {
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
