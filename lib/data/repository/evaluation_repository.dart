import 'package:roadsyouwalked_app/data/db/dao/evaluation_dao.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';
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

  Future<EvaluationScale?> getEvaluationScaleById(final String id) async {
    return await _evaluationDao.getEvaluationScaleById(id);
  }
}
