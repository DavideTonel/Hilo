import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale_item.dart';

class EvaluationScale {
  final String id;
  final String name;
  final List<EvaluationScaleItem> items;

  EvaluationScale({required this.id, required this.name, required this.items});
}
