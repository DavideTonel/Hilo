import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/evaluation_bloc/evaluation_bloc.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale.dart';

class EvaluationPage extends StatelessWidget {
  final Function(EvaluationResultData evaluationResultData) onEvaluationCompleted;

  const EvaluationPage({
    super.key,
    required this.onEvaluationCompleted,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: make it better
    return BlocConsumer<EvaluationBloc, EvaluationState>(
      listener: (context, state) {
        switch (state) {
          case EvaluationLoaded _:
            break;
          case EvaluationCompleted _:
            onEvaluationCompleted(
              state.resultData!
            );
            break;
          default:
        }
      },
      builder: (context, state) {
        Widget body;

        switch (state) {
          case EvaluationInitial _:
            body = Center(child: Text("Loading"));
          case EvaluationLoaded _ || EvaluationInProgress _ || EvaluationCompleted _:
            body = EvaluationWidget(
              items: state.scale!.items,
              scores: state.scores,
              onUpdateScoreItem: (item, score) {
                context.read<EvaluationBloc>().add(
                  SetScoreItem(item: item, score: score),
                );
              },
            );
        }

        return Scaffold(
          body: body,
        );
      },
    );
  }
}

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
    return Column(
      children: [
        ...items.map((item) {
          final currentValue = scores[item];
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
                  onUpdateScoreItem(item, value.toInt());
                },
              ),
            ],
          );
        }),
      ],
    );
  }
}
