/// A class representing the core data of a memory.
///
/// This class stores the essential information of a memory.
class MemoryCoreData {
  /// A unique identifier for the memory.
  final String id;

  /// The ID of the creator of the memory.
  final String creatorId;

  /// The timestamp when the memory was created or recorded.
  final String timestamp;

  /// An optional description of the memory.
  /// This provides additional information about the memory.
  final String? description;

  /// Constructor for creating a [MemoryCoreData] object.
  ///
  /// Parameters:
  /// - [id]: The unique identifier for the memory.
  /// - [creatorId]: The ID of the creator of the memory.
  /// - [timestamp]: The timestamp when the memory was created.
  /// - [description]: The optional description of the memory.
  MemoryCoreData({
    required this.id,
    required this.creatorId,
    required this.timestamp,
    this.description,
  });

  /// Converts the [MemoryCoreData] object into a map.
  ///
  /// This method is useful for converting the object to a format that can be stored or transmitted (e.g., to a database or API).
  ///
  /// Returns a map containing the memory's data.
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "creatorId": creatorId,
      "timestamp": timestamp,
      "description": description,
    };
  }

  /// Creates a [MemoryCoreData] object from a map.
  ///
  /// This factory constructor is used to create a [MemoryCoreData] object from a map, typically retrieved from a database or API.
  ///
  /// Parameters:
  /// - [map]: The map containing the memory's data.
  ///
  /// Returns a [MemoryCoreData] object created from the map.
  factory MemoryCoreData.fromMap(Map<String, dynamic> map) {
    return MemoryCoreData(
      id: map["id"] as String,
      creatorId: map["creatorId"] as String,
      timestamp: map["timestamp"] as String,
      description: map["description"] as String?,
    );
  }
}
