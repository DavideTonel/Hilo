class MemoryBasicData {
  final String creatorId;
  final int timestamp;
  final String? description;

  MemoryBasicData(
    {
      required this.creatorId,
      required this.timestamp,
      required this.description
    }
  );

  Map<String, dynamic> toMap() {
    return {
      "creatorId": creatorId,
      "timestamp": timestamp,
      "description": description,
    };
  }

  factory MemoryBasicData.fromMap(Map<String, dynamic> map) {
    return MemoryBasicData(
      creatorId: map["creatorId"] as String,
      timestamp: map["timestamp"] as int,
      description: map["description"] as String?,
    );
  }
}
