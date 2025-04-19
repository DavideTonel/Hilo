import 'package:roadsyouwalked_app/model/evaluation/affect_type.dart';

class EvaluationScale {
  final String id;
  final String name;
  final List<EvaluationScaleItem> items;

  EvaluationScale({required this.id, required this.name, required this.items});
}

class EvaluationScaleItem {
  final String id;
  final String label;
  final AffectType? affectType;
  final int minValue;
  final int maxValue;

  EvaluationScaleItem({
    required this.id,
    required this.label,
    required this.affectType,
    required this.minValue,
    required this.maxValue,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "label": label,
      "affectType": affectType?.value,
      "minValue": minValue,
      "maxValue": maxValue
    };
  }

  factory EvaluationScaleItem.fromMap(Map<String, dynamic> map) {
    return EvaluationScaleItem(
      id: map["id"] as String,
      label: map["label"] as String,
      affectType: AffectType.fromString(map["affectType"] as String),
      minValue: map["minValue"] as int,
      maxValue: map["maxValue"] as int
    );
  }
}

class EvaluationResultItem {
  //final String memoryId;
  final String evaluationScaleItemId;
  final int score;

  EvaluationResultItem({
    //required this.memoryId,
    required this.evaluationScaleItemId,
    required this.score,
  });

  Map<String, dynamic> toMap() {
    return {
      //"memoryId": memoryId,
      "evaluationScaleItemId": evaluationScaleItemId,
      "score": score
    };
  }

  factory EvaluationResultItem.fromMap(Map<String, dynamic> map) {
    return EvaluationResultItem(
      //memoryId: map["memoryId"] as String,
      evaluationScaleItemId: map["evaluationScaleItemId"] as String,
      score: map["score"] as int
    );
  }
}

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
