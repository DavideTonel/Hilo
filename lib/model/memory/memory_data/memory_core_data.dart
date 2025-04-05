class MemoryCoreData {
  final String id;
  final String creatorId;
  final String timestamp;

  MemoryCoreData(
    {
      required this.id,
      required this.creatorId,
      required this.timestamp
    }
  );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "creatorId": creatorId,
      "timestamp": timestamp
    };
  }

  factory MemoryCoreData.fromMap(Map<String, dynamic> map) {
    return MemoryCoreData(
      id: map["id"] as String,
      creatorId: map["creatorId"] as String,
      timestamp: map["timestamp"] as String
    );
  }
}
