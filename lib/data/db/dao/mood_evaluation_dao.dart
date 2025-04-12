import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/assessment/mood_evaluation.dart';

import 'dart:developer' as dev;

import 'package:sqflite/sqflite.dart';

// TODO: add fromMap and toMap
class MoodEvaluationDao {
  final DatabaseManager _dbManager = DatabaseManager.instance;

  Future<String?> insertMoodEvaluation(final MoodEvaluationData moodEvaluation, final Transaction? transaction) async {
    try {
      final controller = transaction ?? await _dbManager.database;
      await controller.insert(
        "Evaluation",
        {
          "id": moodEvaluation.core.id,
          "creatorId": moodEvaluation.core.creatorId,
          "scaleId": moodEvaluation.score.scores.keys.first.scaleId,
          "timestamp": moodEvaluation.core.timestamp
        },
        conflictAlgorithm: ConflictAlgorithm.abort
      );

      for (var scoreEntry in moodEvaluation.score.scores.entries) {
        await controller.insert(
          "Item_In_Evaluation",
          {
            "id": moodEvaluation.core.id,
            "creatorId": moodEvaluation.core.creatorId,
            "scaleId": scoreEntry.key.scaleId,
            "scaleItemId": scoreEntry.key.id,
            "score": scoreEntry.value
          }
        );
      }

      for (var resultEntry in moodEvaluation.score.results.entries) {
        await controller.insert(
          "Evaluation_Result",
          {
            "evaluationId": moodEvaluation.core.id,
            "creatorId": moodEvaluation.core.creatorId,
            "label": resultEntry.key,
            "value": resultEntry.value
          }
        );
      }

      return moodEvaluation.core.id;
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }

  Future<MoodEvaluationScale?> getEvaluationScaleById(final String id) async {
    try {
      final db = await _dbManager.database;
      final evalData = await db.query(
        "Evaluation_Scale",
        where: "id = ?",
        whereArgs: [ id ],
        limit: 1
      ).then((results) => results.first);

      final List<MoodEvaluationItem> items = await db.query(
        "Evaluation_Scale_Item",
        where: "scaleId = ?",
        whereArgs: [ id ],
        orderBy: "id ASC"
      ).then((results) {
        return results.map((res) => MoodEvaluationItem(
          id: res["id"] as String,
          scaleId: id,
          label: res["label"] as String,
          minValue: res["minValue"] as int,
          maxValue: res["maxValue"] as int,
          affectType: AffectType.fromString(res["affectType"] as String)
        )).toList();
      });

      return MoodEvaluationScale(
        id: id,
        name: evalData["name"] as String,
        items: items
      );
    } catch (e) {
      dev.log(e.toString());
      return null;
    }
  }
}
