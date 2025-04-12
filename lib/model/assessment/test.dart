/*
import 'package:roadsyouwalked_app/model/assessment/affect_type.dart';

abstract class AbstractMoodAssessmentScore {
  final Map<AbstractMoodItem, int?> scores;

  AbstractMoodAssessmentScore({required List<AbstractMoodItem> items}) 
      : scores = Map.fromEntries(items.map((item) => MapEntry(item, null)));

  Map<String, int> getFinalScore();
}

abstract class AbstractMoodScale<T extends AbstractMoodItem> {
  final List<T> items;

  AbstractMoodScale({required this.items});
}


abstract class AbstractMoodItem {
  final String id;
  final String label;
  final int minValue;
  final int maxValue;
  final AffectType? affectType;

  AbstractMoodItem({
    required this.id,
    required this.label,
    required this.minValue,
    required this.maxValue,
    this.affectType,
  });
}



//////////////////////////////////////////////////////

class PanasShortFormScore extends AbstractMoodAssessmentScore {
  PanasShortFormScore({required super.items});

  @override
  Map<String, int> getFinalScore() {
    int positiveSum = 0;
    int negativeSum = 0;

    for (final entry in scores.entries) {
      final item = entry.key;
      final score = entry.value;

      if (score == null) continue;

      if (item.affectType == AffectType.positive) {
        positiveSum += score;
      } else if (item.affectType == AffectType.negative) {
        negativeSum += score;
      }
    }

    return {
      'positive_affect': positiveSum,
      'negative_affect': negativeSum,
    };
  }
}

class PanasShortForm extends AbstractMoodScale<PanasShortFormItem> {
  PanasShortForm({required super.items});

  factory PanasShortForm.standard() { // TODO: rename in english // TODO: put in order
    final items = [
      PanasShortFormItem(
        id: 'interested',
        label: 'Interessato',
        minValue: 1,
        maxValue: 5,
        affectType: AffectType.positive,
      ),
      PanasShortFormItem(
        id: 'distressed',
        label: 'Angosciato',
        minValue: 1,
        maxValue: 5,
        affectType: AffectType.negative,
      ),
      PanasShortFormItem(
        id: 'excited',
        label: 'Eccitato / Elettrizzato',
        minValue: 1,
        maxValue: 5,
        affectType: AffectType.positive,
      ),
      PanasShortFormItem(
        id: 'upset',
        label: 'Irritato / Turbato',
        minValue: 1,
        maxValue: 5,
        affectType: AffectType.negative,
      ),
      PanasShortFormItem(
        id: 'strong',
        label: 'Forte / Energico',
        minValue: 1,
        maxValue: 5,
        affectType: AffectType.positive,
      ),
      PanasShortFormItem(
        id: 'guilty',
        label: 'Colpevole',
        minValue: 1,
        maxValue: 5,
        affectType: AffectType.negative,
      ),
      PanasShortFormItem(
        id: 'scared',
        label: 'Spaventato',
        minValue: 1,
        maxValue: 5,
        affectType: AffectType.negative,
      ),
      PanasShortFormItem(
        id: 'hostile',
        label: 'Ostile',
        minValue: 1,
        maxValue: 5,
        affectType: AffectType.negative,
      ),
      PanasShortFormItem(
        id: 'enthusiastic',
        label: 'Entusiasta',
        minValue: 1,
        maxValue: 5,
        affectType: AffectType.positive,
      ),
      PanasShortFormItem(
        id: 'proud',
        label: 'Orgoglioso',
        minValue: 1,
        maxValue: 5,
        affectType: AffectType.positive,
      ),
    ];

    return PanasShortForm(items: items);
  }
}

class PanasShortFormItem extends AbstractMoodItem {
  PanasShortFormItem({required super.id, required super.label, required super.minValue, required super.maxValue, required super.affectType});
}
*/