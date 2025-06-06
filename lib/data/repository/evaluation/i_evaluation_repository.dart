import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale.dart';
import 'package:roadsyouwalked_app/model/evaluation/export/user_evaluation.dart';
import 'package:sqflite/sqflite.dart';

/// Interface for managing evaluation-related data.
abstract class IEvaluationRepository {
  /// Saves a list of evaluation result items associated with a specific evaluation.
  ///
  /// [evaluationId] - The ID of the evaluation to which the scores belong.
  /// [creatorId] - The ID of the creator of the evaluation.
  /// [evaluationScaleId] - The ID of the evaluation scale used for the evaluation.
  /// [itemScores] - A list of `EvaluationResultItem` objects representing the evaluation scores.
  /// [transaction] - An optional `Transaction` object for performing the operation within a transaction.
  Future<void> saveEvaluationItemScores(
    final String evaluationId,
    final String creatorId,
    final String evaluationScaleId,
    final List<EvaluationResultItem> itemScores,
    Transaction? transaction,
  );

  /// Retrieves an evaluation scale by its ID.
  ///
  /// [id] - The ID of the evaluation scale to be retrieved.
  ///
  /// Returns an `EvaluationScale` object if found, or `null` if the scale is not found.
  Future<EvaluationScale?> getEvaluationScaleById(final String id);

  /// Returns every evaluation a user has made in the last `lastNDays` days,
  /// grouped by memory, with each memory’s timestamp, total score, and items.
  Future<List<UserEvaluation>> getUserEvaluationsLastNDays(
    String userId,
    int lastNDays,
  );
}
