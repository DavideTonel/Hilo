import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale.dart';
import 'package:sqflite/sqflite.dart';

abstract class IEvaluationDao {
  /// Inserts evaluation result items into the database.
  ///
  /// [evaluationId] - The ID of the evaluation associated with these result items.
  /// [creatorId] - The ID of the creator of the evaluation.
  /// [evaluationScaleId] - The ID of the evaluation scale.
  /// [items] - The list of `EvaluationResultItem` objects to be inserted.
  /// [transaction] - An optional database transaction to be used for the insert operation.
  Future<void> insertEvaluationItemScores(
    final String evaluationId,
    final String creatorId,
    final String evaluationScaleId,
    final List<EvaluationResultItem> items,
    final Transaction? transaction,
  );

  /// Retrieves an evaluation scale by its ID.
  ///
  /// [id] - The ID of the evaluation scale to be retrieved.
  ///
  /// Returns the `EvaluationScale` object, or `null` if no scale is found with the provided ID.
  Future<EvaluationScale?> getEvaluationScaleById(final String id);
}