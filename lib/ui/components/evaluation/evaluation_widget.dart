import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale_item.dart';
import 'package:roadsyouwalked_app/ui/components/evaluation/evaluation_item_widget.dart';

class EvaluationWidget extends StatelessWidget {
  final List<EvaluationScaleItem> items;
  final Map<EvaluationScaleItem, int?> scores;
  final Function(EvaluationScaleItem item, int score) onUpdateScoreItem;

  const EvaluationWidget({
    super.key,
    required this.items,
    required this.scores,
    required this.onUpdateScoreItem,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> evaluationItems =
        items.map((item) {
          final currentValue = scores[item] ?? item.minValue;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: EvaluationItemWidget(
              item: item,
              currentValue: currentValue.toDouble(),
              onUpdateScoreItem: onUpdateScoreItem,
            ),
          );
        }).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [...evaluationItems],
    );
  }
}
