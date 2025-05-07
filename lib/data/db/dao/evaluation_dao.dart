import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale_item.dart';

import 'dart:developer' as dev;

import 'package:sqflite/sqflite.dart';

/// Data Access Object (DAO) class for managing evaluation-related operations in the database.
class EvaluationDao {
  // Instance of the DatabaseManager for accessing the database.
  final DatabaseManager _dbManager = DatabaseManager.instance;

  /// Inserts evaluation result items into the database.
  ///
  /// This method inserts a list of evaluation result items into the "Evaluation_Result_Item" table.
  ///
  /// [evaluationId] - The ID of the evaluation associated with these result items.
  /// [creatorId] - The ID of the creator of the evaluation.
  /// [evaluationScaleId] - The ID of the evaluation scale.
  /// [items] - The list of `EvaluationResultItem` objects to be inserted.
  /// [transaction] - An optional database transaction to be used for the insert operation.
  ///
  /// This method inserts each item into the database and ensures that any conflicts are handled by aborting the transaction.
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

  /// Retrieves an evaluation scale by its ID.
  ///
  /// This method queries the "Evaluation_Scale" table to fetch an evaluation scale record and
  /// retrieves the associated items from the "Evaluation_Scale_Item" table.
  ///
  /// [id] - The ID of the evaluation scale to be retrieved.
  ///
  /// Returns the `EvaluationScale` object, or `null` if no scale is found with the provided ID.
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
