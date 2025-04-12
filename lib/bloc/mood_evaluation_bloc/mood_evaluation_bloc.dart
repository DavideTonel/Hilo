import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/data/repository/mood_evaluation_repository.dart';
import 'package:roadsyouwalked_app/model/assessment/mood_evaluation.dart';
import 'package:roadsyouwalked_app/model/assessment/mood_evaluation_helper.dart';

part 'mood_evaluation_event.dart';
part 'mood_evaluation_state.dart';

class MoodEvaluationBloc extends Bloc<MoodEvaluationEvent, MoodEvaluationState> {
  final MoodEvaluationRepository _evaluationRepository = MoodEvaluationRepository();
  
  MoodEvaluationBloc() : super(MoodEvaluationInitial()) {
    on<GetDefaultEvaluationScale>(onGetDefaultEvaluationScale);
    on<SetScoreMoodItem>(onSetScoreMoodItem);
  }

  Future<void> onGetDefaultEvaluationScale(
    GetDefaultEvaluationScale event,
    Emitter<MoodEvaluationState> emit
  ) async {
    // TODO: get last scaleId used by user
    // TODO: add try catch if an error occours
    final MoodEvaluationScale? scale = await _evaluationRepository.getEvaluationScaleById("panas_sf");
    final Map<MoodEvaluationItem, int?> scores = {
      for (var item in scale!.items) item : null
    };

    emit(
      MoodEvaluationInProgress(
        scale: scale,
        scores: scores
      )
    );
  }

  void onSetScoreMoodItem(
    SetScoreMoodItem event,
    Emitter<MoodEvaluationState> emit
  ) {
    final newScores = state.scores;
    newScores[event.item] = event.score;

    if (newScores.values.every((value) => value != null)) {
      // TODO: this saves the first all scores are setted, but user needs to approve that
      final Map<String, int> results = MoodEvaluationHelper().calculareResultsFromScores(state.scores);
      emit(
        MoodEvaluationCompleted(
          scale: state.scale,
          scores: newScores,
          results: results
        )
      );
    } else {
      emit(
        MoodEvaluationInProgress(
          scale: state.scale,
          scores: newScores
        )
      );
    }
  }
}
