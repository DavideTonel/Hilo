part of 'assessment_bloc.dart';

@immutable
sealed class AssessmentEvent<T extends AbstractMoodItem> {}

final class UpdateMoodScore<T extends AbstractMoodItem> extends AssessmentEvent<T> {
  final AbstractMoodItem item;
  final int score;

  UpdateMoodScore({required this.item, required this.score});
}

class SubmitAssessment<T extends AbstractMoodItem> extends AssessmentEvent<T> {}
