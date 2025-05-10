part of 'evaluation_bloc.dart';

@immutable
sealed class EvaluationEvent {}

final class GetDefaultEvaluationScale extends EvaluationEvent {}

final class SetScoreItem extends EvaluationEvent {
  final EvaluationScaleItem item;
  final int score;

  SetScoreItem({required this.item, required this.score});
}
