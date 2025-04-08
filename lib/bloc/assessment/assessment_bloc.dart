import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/model/assessment/test.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';

class AssessmentBloc<T extends AbstractMoodItem>
    extends Bloc<AssessmentEvent<T>, AssessmentState<T>> {
  final AbstractMoodAssessmentScore Function(List<T>) scoreBuilder;

  AssessmentBloc({
    required AbstractMoodScale<T> scale,
    required this.scoreBuilder,
  }) : super(
    AssessmentInitial<T>(
      scale: scale,
      scoreBuilder: scoreBuilder,
    ),
  ) {
    on<UpdateMoodScore<T>>(_onUpdateScore);
    on<SubmitAssessment<T>>(_onSubmit);
  }

  void _onUpdateScore(
    UpdateMoodScore<T> event,
    Emitter<AssessmentState<T>> emit,
  ) {
    final updatedScores = Map.of(state.score.scores);
    updatedScores[event.item] = event.score;

    final updatedScore = scoreBuilder(state.scale.items);
    updatedScore.scores.clear();
    updatedScore.scores.addAll(updatedScores);

    emit(
      AssessmentInProgress<T>(
        scale: state.scale,
        score: updatedScore,
        submitted: false,
      ),
    );
  }

  void _onSubmit(
    SubmitAssessment<T> event,
    Emitter<AssessmentState<T>> emit,
  ) {
    emit(
      AssessmentInProgress<T>(
        scale: state.scale,
        score: state.score,
        submitted: true,
      ),
    );
  }
}
