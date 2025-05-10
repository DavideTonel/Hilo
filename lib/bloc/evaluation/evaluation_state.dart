part of 'evaluation_bloc.dart';

@immutable
sealed class EvaluationState {
  final EvaluationScale? scale;
  final Map<EvaluationScaleItem, int?> scores;
  final EvaluationResultData? resultData;

  const EvaluationState({
    required this.scale,
    required this.scores,
    required this.resultData
  });
}

final class EvaluationInitial extends EvaluationState {
  const EvaluationInitial({
    super.scale,
    super.scores = const {},
    super.resultData
  });
}

final class EvaluationLoaded extends EvaluationState {
  const EvaluationLoaded({
    required super.scale,
    required super.scores,
    super.resultData
  });
}

final class EvaluationInProgress extends EvaluationState {
  const EvaluationInProgress({
    required super.scale,
    required super.scores,
    super.resultData
  });
}

final class EvaluationCompleted extends EvaluationState {
  const EvaluationCompleted({
    required super.scale,
    required super.scores,
    required super.resultData
  });
}
