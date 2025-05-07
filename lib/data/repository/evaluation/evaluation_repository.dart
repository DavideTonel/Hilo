import 'package:roadsyouwalked_app/data/db/dao/evaluation/evaluation_dao.dart';
import 'package:roadsyouwalked_app/data/db/dao/evaluation/i_evaluation_dao.dart';
import 'package:roadsyouwalked_app/data/repository/evaluation/i_evaluation_repository.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale.dart';
import 'package:roadsyouwalked_app/model/evaluation/export/user_evaluation.dart';
import 'package:sqflite/sqflite.dart';

/// A repository class for managing evaluation-related data.
/// A concrete implementation of [IEvaluationRepository].
class EvaluationRepository extends IEvaluationRepository {
  final IEvaluationDao _evaluationDao = EvaluationDao();

  @override
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

  @override
  Future<EvaluationScale?> getEvaluationScaleById(final String id) async {
    return await _evaluationDao.getEvaluationScaleById(id);
  }

  @override
  Future<List<UserEvaluation>> getUserEvaluationsLastNDays(
    String userId,
    int lastNDays,
  ) async {
    return await _evaluationDao.getUserEvaluationsLastNDays(userId, lastNDays);
  }
}
