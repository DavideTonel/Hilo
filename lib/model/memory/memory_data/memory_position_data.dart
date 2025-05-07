/// A class that stores geographical position data for a memory.
class MemoryPositionData {
  /// The latitude of the memory's location.
  final double latitude;

  /// The longitude of the memory's location.
  final double longitude;

  /// Creates a [MemoryPositionData] with the given [latitude] and [longitude].
  MemoryPositionData({required this.latitude, required this.longitude});

  /// Converts this [MemoryPositionData] into a map.
  ///
  /// This is useful for serializing the object, for instance, when saving it
  /// to a database or sending it over the network.
  ///
  /// Returns a map.
  Map<String, dynamic> toMap() {
    return {
      "latitude": latitude,
      "longitude": longitude
    };
  }

  /// Converts a map into a [MemoryPositionData] object.
  ///
  /// Takes a map and returns an instance
  /// of [MemoryPositionData]. If either value is missing, the method returns null.
  ///
  /// [map] The map that contains the latitude and longitude values.
  ///
  /// Returns a [MemoryPositionData] object or null if the map is incomplete.
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
