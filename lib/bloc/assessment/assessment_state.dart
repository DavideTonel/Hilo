part of 'assessment_bloc.dart';

@immutable
sealed class AssessmentState<T extends AbstractMoodItem> {
  final AbstractMoodScale<T> scale;
  final AbstractMoodAssessmentScore score;
  final bool submitted;

  const AssessmentState({
    required this.scale,
    required this.score,
    required this.submitted,
  });
}

final class AssessmentInitial<T extends AbstractMoodItem> extends AssessmentState<T> {
  AssessmentInitial({
    required super.scale,
    required AbstractMoodAssessmentScore Function(List<T> items) scoreBuilder,
  }) : super(
    score: scoreBuilder(scale.items),
    submitted: false,
  );
}

final class AssessmentInProgress<T extends AbstractMoodItem> extends AssessmentState<T> {
  const AssessmentInProgress({
    required super.scale,
    required super.score,
    required super.submitted,
  });
}
