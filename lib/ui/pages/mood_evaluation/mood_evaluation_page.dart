import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/mood_evaluation_bloc/mood_evaluation_bloc.dart';

class MoodEvaluationPage extends StatelessWidget {
  const MoodEvaluationPage({super.key});

  @override
  Widget build(BuildContext context) {    // TODO: make it better
    return BlocBuilder<MoodEvaluationBloc, MoodEvaluationState>(
      builder: (context, state) {
        final scale = state.scale;
        final scores = state.scores;

        return Scaffold(
          body: Column( children: [
            ...scale!.items.map((item) {
              final currentValue = scores[item];  // TODO: could be null
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.label),
                  Slider(
                    value: (currentValue ?? item.minValue).toDouble(),
                    min: item.minValue.toDouble(),
                    max: item.maxValue.toDouble(),
                    divisions: item.maxValue - item.minValue,
                    label: (currentValue ?? item.minValue).toString(),
                    onChanged: (value) {
                      context.read<MoodEvaluationBloc>().add(
                        SetScoreMoodItem(item: item, score: value.toInt()),
                      );
                    },
                  ),
                ],
              );
            }),
          ],
        )
      );
      },
    );
  }
}
