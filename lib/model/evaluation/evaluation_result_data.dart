import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';

class EvaluationResultData {
  final String evaluationScaleId;
  final Map<String, double> result;
  final List<EvaluationResultItem> singleItemScores;

  EvaluationResultData({
    required this.evaluationScaleId,
    required this.result,
    required this.singleItemScores,
  });
}
