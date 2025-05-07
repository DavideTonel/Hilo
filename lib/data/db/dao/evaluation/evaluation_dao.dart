import 'package:roadsyouwalked_app/data/db/dao/evaluation/i_evaluation_dao.dart';
import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale_item.dart';

import 'dart:developer' as dev;

import 'package:sqflite/sqflite.dart';

/// Data Access Object (DAO) class for managing evaluation-related operations in the database.
/// Concrete implementation of [IEvaluationDao] for accessing evaluations
/// stored in a local SQLite database.
class EvaluationDao extends IEvaluationDao {
  // Instance of the DatabaseManager for accessing the database.
  final DatabaseManager _dbManager = DatabaseManager.instance;

  @override
  Future<void> insertEvaluationItemScores(
    final String evaluationId,
    final String creatorId,
    final String evaluationScaleId,
    final List<EvaluationResultItem> items,
    final Transaction? transaction,
  ) async {
    try {
      final controller = transaction ?? await _dbManager.database;
      for (final item in items) {
        await controller.insert("Evaluation_Result_Item", {
          "memoryId": evaluationId,
          "creatorId": creatorId,
          "evaluationScaleId": evaluationScaleId,
          ...item.toMap(),
        }, conflictAlgorithm: ConflictAlgorithm.abort);
      }
    } catch (e) {
      dev.log(e.toString());
    }
  }

  @override
  Future<EvaluationScale?> getEvaluationScaleById(final String id) async {
    try {
      final db = await _dbManager.database;
      
      // Retrieve the evaluation scale data.
      final evalData = await db
          .query("Evaluation_Scale", where: "id = ?", whereArgs: [id], limit: 1)
          .then((results) => results.first);

      // Retrieve the items associated with the evaluation scale.
      final List<EvaluationScaleItem> items = await db
          .query(
            "Evaluation_Scale_Item",
            where: "evaluationScaleId = ?",
            whereArgs: [id],
            orderBy: "id ASC",
          )
          .then((results) {
            return results
                .map((res) => EvaluationScaleItem.fromMap(res))
                .toList();
          });

      // Return the constructed EvaluationScale object with its items.
      return EvaluationScale(
        id: id,
        name: evalData["name"] as String,
        items: items,
      );
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }
}
