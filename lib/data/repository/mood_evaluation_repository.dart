import 'package:roadsyouwalked_app/data/db/dao/mood_evaluation_dao.dart';
import 'package:roadsyouwalked_app/model/assessment/mood_evaluation.dart';
import 'package:sqflite/sqflite.dart';

class MoodEvaluationRepository {
  final MoodEvaluationDao _evaluationDao = MoodEvaluationDao();

  Future<void> saveMoodEvaluationDone(final MoodEvaluationData moodEvaluationData, final Transaction? transaction) async {
    await _evaluationDao.insertMoodEvaluation(moodEvaluationData, transaction);
  }

  Future<MoodEvaluationScale?> getEvaluationScaleById(final String id) async {
    return await _evaluationDao.getEvaluationScaleById(id);
  }
}
