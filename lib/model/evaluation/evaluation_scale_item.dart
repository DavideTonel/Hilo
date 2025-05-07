import 'package:roadsyouwalked_app/model/evaluation/affect_type.dart';

/// Represents an individual item in an evaluation scale, such as a question
/// or subscale, with associated properties like the affect type and score range.
///
/// This class is typically used to model items within a scale used for mood
/// or psychological assessments, where each item has an affective association
/// (positive or negative) and a score range (minimum and maximum).
class EvaluationScaleItem {
  /// The unique identifier of the evaluation scale item (e.g., question or subscale).
  final String id;

  /// A label or description for the evaluation scale item (e.g., question text).
  final String label;

  /// The affect type associated with the evaluation scale item, indicating whether it
  /// is related to a positive or negative emotional state. It is nullable if no affect type is provided.
  final AffectType? affectType;

  /// The minimum score possible for this evaluation scale item.
  final int minValue;

  /// The maximum score possible for this evaluation scale item.
  final int maxValue;

  /// Creates an [EvaluationScaleItem] instance with the provided parameters.
  EvaluationScaleItem({
    required this.id,
    required this.label,
    required this.affectType,
    required this.minValue,
    required this.maxValue,
  });

  /// Converts the [EvaluationScaleItem] into a map for serialization purposes.
  ///
  /// This method is typically used to convert the instance into a format
  /// suitable for storage or communication (e.g., database, API).
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "label": label,
      "affectType": affectType?.value,
      "minValue": minValue,
      "maxValue": maxValue,
    };
  }

  /// Creates an [EvaluationScaleItem] instance from a map.
  ///
  /// This factory constructor is typically used to deserialize data from
  /// storage or external sources (e.g., a database or API response).
  factory EvaluationScaleItem.fromMap(Map<String, dynamic> map) {
    return EvaluationScaleItem(
      id: map["id"] as String,
      label: map["label"] as String,
      affectType: AffectType.fromString(map["affectType"] as String),
      minValue: map["minValue"] as int,
      maxValue: map["maxValue"] as int,
    );
  }
}
