/// Holds one evaluation item’s label and score.
class EvaluationDetail {
  final String itemId;
  final String label;
  final int score;

  EvaluationDetail({required this.itemId, required this.label, required this.score});

  /// Convert this detail into a JSON‐compatible map.
  Map<String, dynamic> toJson() => {
    "itemId": itemId,
    "label": label,
    "score": score,
  };
}