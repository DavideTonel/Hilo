import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale_item.dart';

/// Represents a full evaluation scale, which is a collection of evaluation scale items.
/// Each scale can consist of multiple items (e.g., questions or subscales), each with
/// its own properties such as score range and affect type.
///
/// This class is used to model an entire scale that can be applied for mood assessments
/// or other psychological evaluations, allowing for multiple items to be grouped together
/// under a common evaluation scale.
class EvaluationScale {
  /// The unique identifier for the evaluation scale.
  final String id;

  /// The name or title of the evaluation scale (e.g., "Mood Assessment", "Satisfaction Scale").
  final String name;

  /// A list of evaluation scale items that belong to this scale.
  ///
  /// Each item contains specific information such as the score range and
  /// whether the item has a positive or negative affect type.
  final List<EvaluationScaleItem> items;

  /// Creates an [EvaluationScale] instance with the provided parameters.
  ///
  /// [id] is the unique identifier of the scale.
  /// [name] is the name of the scale.
  /// [items] is the list of [EvaluationScaleItem] instances that make up the scale.
  EvaluationScale({
    required this.id,
    required this.name,
    required this.items,
  });
}
