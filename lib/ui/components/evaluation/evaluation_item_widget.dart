import 'package:flutter/material.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale_item.dart';

class EvaluationItemWidget extends StatelessWidget {
  final EvaluationScaleItem item;
  final double currentValue;
  final Function(EvaluationScaleItem item, int score) onUpdateScoreItem;

  const EvaluationItemWidget({
    super.key,
    required this.item,
    required this.currentValue,
    required this.onUpdateScoreItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 3,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
          ),
          child: Slider(
            value: currentValue.toDouble(),
            min: item.minValue.toDouble(),
            max: item.maxValue.toDouble(),
            divisions: item.maxValue - item.minValue,
            label: currentValue.toInt().toString(),
            onChanged: (value) {
              onUpdateScoreItem(item, value.toInt());
            },
          ),
        ),
      ],
    );
  }
}
