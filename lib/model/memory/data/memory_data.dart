import 'package:roadsyouwalked_app/model/memory/data/memory_basic_data.dart';

class MemoryData {
  final MemoryBasicData basic;

  MemoryData({required this.basic});

  Map<String, dynamic> toMap() {
    return {
      "basic": basic.toMap(),
    };
  }

  factory MemoryData.fromMap(Map<String, dynamic> map) {
    return MemoryData(
      basic: MemoryBasicData.fromMap(map["basic"] as Map<String, dynamic>),
    );
  }
}
