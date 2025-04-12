class MoodEvaluation {
  final MoodEvaluationData data;

  MoodEvaluation({required this.data});
}

class MoodEvaluationData {
  final MoodEvaluationCoreData core;
  final MoodEvaluationScoreData score;

  MoodEvaluationData({required this.core, required this.score});
}

class MoodEvaluationCoreData {
  final String id;
  final String creatorId;
  final String timestamp;

  MoodEvaluationCoreData({
    required this.id,
    required this.creatorId,
    required this.timestamp
  });
}

class MoodEvaluationScoreData {
  final Map<MoodEvaluationItem, int?> scores;
  final Map<String, int?> results;

  MoodEvaluationScoreData({required this.scores, required this.results});
}

class MoodEvaluationScale {
  // id
  final String id;

  final String name;
  final List<MoodEvaluationItem> items;

  MoodEvaluationScale({
    required this.id,
    required this.name,
    required this.items
  });
}

class MoodEvaluationItem {
  // id
  final String id;
  final String scaleId;

  final String label;
  final int minValue;
  final int maxValue;
  final AffectType? affectType;

  MoodEvaluationItem({
    required this.id,
    required this.scaleId,
    required this.label,
    required this.minValue,
    required this.maxValue,
    required this.affectType
  });
}

enum AffectType {
  positive(value: "positive"),
  negative(value: "negative");

  final String value;

  const AffectType({required this.value});

  factory AffectType.fromString(String value) {
    return AffectType.values.firstWhere(
      (type) => type.value == value,
    );
  }
}
