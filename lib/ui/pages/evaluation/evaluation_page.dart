import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/evaluation_bloc/evaluation_bloc.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_data.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale_item.dart';

class EvaluationPage extends StatefulWidget {
  final Function(EvaluationResultData evaluationResultData)
  onEvaluationCompleted;

  const EvaluationPage({super.key, required this.onEvaluationCompleted});

  @override
  _EvaluationPageState createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EvaluationBloc, EvaluationState>(
      listener: (context, state) {
        if (state is EvaluationCompleted) {
          widget.onEvaluationCompleted(state.resultData!);
        }
      },
      builder: (context, state) {
        Widget body;
        double progress = 0;

        if (state is EvaluationInitial) {
          body = const Center(child: Text("Loading..."));
        } else if (state is EvaluationLoaded ||
            state is EvaluationInProgress ||
            state is EvaluationCompleted) {
          final items = state.scale!.items;
          final scores = state.scores;

          final completed = scores.values.where((v) => v != null).length;
          progress = completed / items.length;

          // Update the animation progress
          _progressAnimation = Tween<double>(
            begin: _progressAnimation.value,
            end: progress,
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOut,
            ),
          );
          _animationController.forward(from: 0); // Trigger the animation

          body = Padding(
            padding: const EdgeInsets.all(27.0),
            child: EvaluationWidget(
              items: items,
              scores: scores,
              onUpdateScoreItem: (item, score) {
                context.read<EvaluationBloc>().add(
                  SetScoreItem(item: item, score: score),
                );
              },
            ),
          );
        } else {
          body = const Center(child: Text("Unexpected state"));
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("How are you?"),
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _progressAnimation.value,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  );
                },
              ),
            ),
          ),
          body: body,
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
    List<Widget> evaluationItems =
        items.map((item) {
          final currentValue = scores[item] ?? item.minValue;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
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
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: currentValue.toDouble(),
          min: item.minValue.toDouble(),
          max: item.maxValue.toDouble(),
          divisions: item.maxValue - item.minValue,
          label: currentValue.toInt().toString(),
          onChanged: (value) {
            onUpdateScoreItem(item, value.toInt());
          },
        ),
      ],
    );
  }
}
