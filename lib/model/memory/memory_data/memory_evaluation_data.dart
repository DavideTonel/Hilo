import 'dart:convert';

class MemoryEvaluationData {
  final String evaluationScaleId;
  final Map<String, double> evaluationResult;

  MemoryEvaluationData({
    required this.evaluationScaleId,
    required this.evaluationResult,
  });

  factory MemoryEvaluationData.fromMap(final Map<String, dynamic> map) {
    return MemoryEvaluationData(
      evaluationScaleId: map["evaluationScaleId"] as String,
      evaluationResult: (json.decode(map["resultJson"]) as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, (value as num).toDouble())),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "evaluationScaleId": evaluationScaleId,
      "resultJson": json.encode(evaluationResult)
    };
  }
}
