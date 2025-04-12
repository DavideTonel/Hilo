part of 'mood_evaluation_bloc.dart';

@immutable
sealed class MoodEvaluationState {
  //final List<MoodEvaluationItem> items;
  final MoodEvaluationScale? scale;
  final Map<MoodEvaluationItem, int?> scores;
  final Map<String, int>? results;

  const MoodEvaluationState({
    //required this.items,
    required this.scale,
    required this.scores,
    required this.results
  });
}

final class MoodEvaluationInitial extends MoodEvaluationState {
  const MoodEvaluationInitial({
    //super.items = const [],
    super.scale,
    super.scores = const {},
    super.results
  });
}

final class MoodEvaluationInProgress extends MoodEvaluationState {
  const MoodEvaluationInProgress({
    //required super.items,
    required super.scale,
    required super.scores,
    super.results
  });
}

final class MoodEvaluationCompleted extends MoodEvaluationState {
  const MoodEvaluationCompleted({
    required super.scale,
    required super.scores,
    required super.results
  });
}
