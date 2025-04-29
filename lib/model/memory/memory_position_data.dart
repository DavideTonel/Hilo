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

  static MemoryPositionData? fromMap(Map<String, dynamic> map) {
    final lat = map["latitude"];
    final lon = map["longitude"];
    if (lat == null || lon == null) return null;

    return MemoryPositionData(
      latitude: lat as double,
      longitude: lon as double,
    );
  }
}
