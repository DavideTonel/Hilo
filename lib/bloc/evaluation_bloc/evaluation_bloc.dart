import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:roadsyouwalked_app/data/repository/evaluation/evaluation_repository.dart';
import 'package:roadsyouwalked_app/data/repository/evaluation/i_evaluation_repository.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_data.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale_item.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_helper.dart';

part 'evaluation_event.dart';
part 'evaluation_state.dart';

class EvaluationBloc extends Bloc<EvaluationEvent, EvaluationState> {
  final IEvaluationRepository _evaluationRepository = EvaluationRepository();
  
  EvaluationBloc() : super(EvaluationInitial()) {
    on<GetDefaultEvaluationScale>(onGetDefaultEvaluationScale);
    on<SetScoreItem>(onSetScoreItem);
  }

  Future<void> onGetDefaultEvaluationScale(
    GetDefaultEvaluationScale event,
    Emitter<EvaluationState> emit
  ) async {
    final EvaluationScale? scale = await _evaluationRepository.getEvaluationScaleById("panas_sf");
    final Map<EvaluationScaleItem, int?> scores = {
      for (var item in scale!.items) item : null
    };

    emit(
      EvaluationLoaded(
        scale: scale,
        scores: scores
      )
    );
  }

  void onSetScoreItem(
    SetScoreItem event,
    Emitter<EvaluationState> emit
  ) {
    final newScores = state.scores;
    newScores[event.item] = event.score;

    if (newScores.values.every((value) => value != null)) {
      final Map<String, double> results = EvaluationHelper().calculareResultsFromScores(newScores);
      emit(
        EvaluationCompleted(
          scale: state.scale,
          scores: newScores,
          resultData: EvaluationResultData(
            evaluationScaleId: state.scale!.id,
            result: results,
            singleItemScores: newScores.entries.map((entry) => EvaluationResultItem(evaluationScaleItemId: entry.key.id, score: entry.value!)).toList(),
          )
        )
      );
    } else {
      emit(
        EvaluationInProgress(
          scale: state.scale,
          scores: newScores
        )
      );
    }
  }
}
