import 'package:roadsyouwalked_app/model/evaluation/affect_type.dart';

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
