import 'package:roadsyouwalked_app/model/memory/memory_data/memory_core_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_evaluation_data.dart';

class MemoryData {
  final MemoryCoreData core;
  final MemoryEvaluationData evaluation;

  Map<String, dynamic> toMap() {
    return {
      ...core.toMap(),
      ...evaluation.toMap()
    };
  }

  factory MemoryData.fromMap(Map<String, dynamic> map) {
    return MemoryData(
      core:  MemoryCoreData.fromMap(map),
      evaluation: MemoryEvaluationData.fromMap(map)
    );
  }

  MemoryData({required this.core, required this.evaluation});
}
