import 'package:roadsyouwalked_app/data/db/dao/evaluation_dao.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale.dart';
import 'package:sqflite/sqflite.dart';

class EvaluationRepository {
  final EvaluationDao _evaluationDao = EvaluationDao();

  Future<void> saveEvaluationItemScores(
    final String evaluationId,
    final String creatorId,
    final String evaluationScaleId,
    final List<EvaluationResultItem> itemScores,
    Transaction? transaction,
  ) async {
    await _evaluationDao.insertEvaluationItemScores(
      evaluationId,
      creatorId,
      evaluationScaleId,
      itemScores,
      transaction,
    );
  }

  /*
  Future<void> saveMoodEvaluationDone(final MoodEvaluationData moodEvaluationData, final Transaction? transaction) async {
    await _evaluationDao.insertMoodEvaluation(moodEvaluationData, transaction);
  }
  */

  Future<EvaluationScale?> getEvaluationScaleById(final String id) async {
    return await _evaluationDao.getEvaluationScaleById(id);
  }

  /*
  Future<List<MoodEvaluation>> getMoodEvaluationsByUserId(final String userId) async {
    return await _evaluationDao.getMoodEvaluationsByUserId(userId);
  }
  */
}
