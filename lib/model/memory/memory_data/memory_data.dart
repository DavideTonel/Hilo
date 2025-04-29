import 'package:roadsyouwalked_app/model/memory/memory_data/memory_core_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_evaluation_data.dart';
import 'package:roadsyouwalked_app/model/memory/memory_position_data.dart';

class MemoryData {
  final MemoryCoreData core;
  final MemoryEvaluationData evaluation;
  final MemoryPositionData? position;

  MemoryData({required this.core, required this.evaluation, this.position});

  Map<String, dynamic> toMap() {
    return {
      ...core.toMap(),
      ...evaluation.toMap(),
      ...?position?.toMap()
    };
  }

  factory MemoryData.fromMap(Map<String, dynamic> map) {
    return MemoryData(
      core:  MemoryCoreData.fromMap(map),
      evaluation: MemoryEvaluationData.fromMap(map),
      position: MemoryPositionData.fromMap(map)
    );
  }
}
