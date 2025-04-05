import 'package:roadsyouwalked_app/model/memory/memory_data/memory_core_data.dart';

class MemoryData {
  final MemoryCoreData core;

  MemoryData(
    {
      required this.core,
    }
  );

  Map<String, dynamic> toMap() {
    return core.toMap();
  }
}
