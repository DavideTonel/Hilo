part of 'mood_evaluation_bloc.dart';

@immutable
sealed class MoodEvaluationEvent {}

final class GetDefaultEvaluationScale extends MoodEvaluationEvent {}

final class SetScoreMoodItem extends MoodEvaluationEvent {
  final MoodEvaluationItem item;
  final int score;

  SetScoreMoodItem({required this.item, required this.score});
}
