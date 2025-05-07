import 'package:roadsyouwalked_app/data/db/dao/evaluation/i_evaluation_dao.dart';
import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_result_item.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale.dart';
import 'package:roadsyouwalked_app/model/evaluation/evaluation_scale_item.dart';
import 'package:roadsyouwalked_app/model/evaluation/export/user_evaluation.dart';
import 'package:roadsyouwalked_app/model/evaluation/export/user_evaluation_detail.dart';

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

  @override
  Future<List<UserEvaluation>> getUserEvaluationsLastNDays(
    String userId,
    int lastNDays,
  ) async {
    try {
      final db = await _dbManager.database;
      final cutoff =
          DateTime.now().subtract(Duration(days: lastNDays)).toIso8601String();

      final rows = await db.rawQuery(
        '''
        SELECT
          m.id            AS memoryId,
          m.timestamp     AS ts,
          eri.evaluationScaleItemId AS itemId,
          esi.label       AS label,
          eri.score       AS itemScore
        FROM Memory m
        JOIN Evaluation_Result_Item eri
          ON m.id = eri.memoryId
          AND m.creatorId = eri.creatorId
        JOIN Evaluation_Scale_Item esi
          ON eri.evaluationScaleItemId = esi.id
          AND eri.evaluationScaleId = esi.evaluationScaleId
        WHERE m.creatorId = ?
          AND m.timestamp  >= ?
        ORDER BY m.timestamp ASC
        ''',
        [userId, cutoff],
      );

      final Map<String, List<Map<String, Object?>>> grouped = {};
      for (final row in rows) {
        final memId = row['memoryId'] as String;
        grouped.putIfAbsent(memId, () => []).add(row);
      }

      final List<UserEvaluation> result = [];
      for (final entry in grouped.entries) {
        final memId = entry.key;
        final items = entry.value;

        final tsString = items.first['ts'] as String;
        final timestamp = DateTime.parse(tsString);

        final details =
            items
                .map(
                  (r) => EvaluationDetail(
                    itemId: r['itemId'] as String,
                    label: r['label'] as String,
                    score: r['itemScore'] as int,
                  ),
                )
                .toList();

        result.add(
          UserEvaluation(
            memoryId: memId,
            timestamp: timestamp,
            details: details,
          ),
        );
      }
      return result;
    } catch (e) {
      dev.log(e.toString());
      return [];
    }
  }
}
