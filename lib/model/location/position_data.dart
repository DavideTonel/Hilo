/// A simple data class that represents a geographical position.
///
/// Example usage:
/// ```dart
/// final position = PositionData(latitude: 45.4642, longitude: 9.1900);
/// print("Lat: ${position.latitude}, Lng: ${position.longitude}");
/// ```
///
/// Properties:
/// - [latitude]: The north-south coordinate in decimal degrees.
/// - [longitude]: The east-west coordinate in decimal degrees.
class PositionData {
  final double latitude;
  final double longitude;

  PositionData({required this.latitude, required this.longitude});
}
