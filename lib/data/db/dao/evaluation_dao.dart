import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale.dart';

import 'dart:developer' as dev;

import 'package:sqflite/sqflite.dart';

class EvaluationDao {
  final DatabaseManager _dbManager = DatabaseManager.instance;

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

  Future<EvaluationScale?> getEvaluationScaleById(final String id) async {
    try {
      final db = await _dbManager.database;
      final evalData = await db
          .query("Evaluation_Scale", where: "id = ?", whereArgs: [id], limit: 1)
          .then((results) => results.first);

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
