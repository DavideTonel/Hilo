import 'package:roadsyouwalked_app/model/evaluation/export/user_evaluation_detail.dart';

/// Holds all of a single memory’s evaluation.
class UserEvaluation {
  final String memoryId;
  final DateTime timestamp;
  final List<EvaluationDetail> details;

  UserEvaluation({
    required this.memoryId,
    required this.timestamp,
    required this.details,
  });

  /// Convert this entire evaluation into a JSON‐compatible map.
  Map<String, dynamic> toJson() => {
    "memoryId": memoryId,
    "timestamp": timestamp.toIso8601String(),
    "details": details.map((d) => d.toJson()).toList(),
  };
}