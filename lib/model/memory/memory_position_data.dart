class MemoryPositionData {
  final double latitude;
  final double longitude;

  MemoryPositionData({required this.latitude, required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      "latitude": latitude,
      "longitude": longitude
    };
  }

  factory MemoryPositionData.fromMap(Map<String, dynamic> map) {
    return MemoryPositionData(
      latitude: map["latitude"] as double,
      longitude: map["longitude"] as double
    );
  }
}
