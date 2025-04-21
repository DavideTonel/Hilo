class EvaluationResultItem {
  final String evaluationScaleItemId;
  final int score;

  EvaluationResultItem({
    required this.evaluationScaleItemId,
    required this.score,
  });

  Map<String, dynamic> toMap() {
    return {
      "evaluationScaleItemId": evaluationScaleItemId,
      "score": score
    };
  }

  factory EvaluationResultItem.fromMap(Map<String, dynamic> map) {
    return EvaluationResultItem(
      evaluationScaleItemId: map["evaluationScaleItemId"] as String,
      score: map["score"] as int
    );
  }
}
