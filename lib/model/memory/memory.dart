import 'package:roadsyouwalked_app/model/memory/data/memory_data.dart';

class Memory {
  final String id;
  final MemoryData data;

  Memory(
    {
      required this.id,
      required this.data
    }
  );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "data": data.toMap(),
    };
  }

  factory Memory.fromMap(Map<String, dynamic> map) {
    return Memory(
      id: map["id"] as String,
      data: MemoryData.fromMap(map["data"] as Map<String, dynamic>),
    );
  }
}
