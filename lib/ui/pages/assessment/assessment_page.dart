import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadsyouwalked_app/bloc/assessment/assessment_bloc.dart';
import 'package:roadsyouwalked_app/model/assessment/test.dart';

class AssessmentPage<T extends AbstractMoodItem> extends StatelessWidget {
  const AssessmentPage({super.key});

  @override
  Widget build(BuildContext context) {    // TODO: make it better
    return BlocBuilder<AssessmentBloc<T>, AssessmentState<T>>(
      builder: (context, state) {
        final scale = state.scale;
        final scores = state.score.scores;

        return Scaffold(
          body: Column( children: [
            Text(
              'Valutazione dell’umore',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            ...scale.items.map((item) {
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
                      context.read<AssessmentBloc<T>>().add(
                        UpdateMoodScore(item: item, score: value.toInt()),
                      );
                    },
                  ),
                ],
              );
            }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<AssessmentBloc<T>>().add(SubmitAssessment<T>());
              },
              child: const Text("Invia"),
            ),
            if (state.submitted) ...[
              const SizedBox(height: 16),
              const Text(
                "Assessment inviato!",
                style: TextStyle(color: Colors.green),
              ),
              const SizedBox(height: 8),
              Text("Risultato: ${state.score.getFinalScore()}"),
            ],
          ],
        )
      );
      },
    );
  }
}
