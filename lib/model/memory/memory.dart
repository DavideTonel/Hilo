import 'package:roadsyouwalked_app/model/media/media.dart';
import 'package:roadsyouwalked_app/model/memory/memory_data/memory_data.dart';

/// A class representing a memory.
class Memory {
  /// The core data of the memory (timestamp, creator, description, etc.).
  final MemoryData data;

  /// A list of media items (images, videos, etc.) associated with this memory.
  List<Media> mediaList;

  /// Creates a new memory with the specified [data] and optional [mediaList].
  ///
  /// [data] The core data associated with the memory.
  /// [mediaList] A list of media items (default is an empty list).
  Memory({
    required this.data,
    this.mediaList = const [],
  });

  /// Converts the memory object into a map format for serialization.
  ///
  /// Returns a [Map<String, dynamic>] representing the memory data.
  Map<String, dynamic> toMap() {
    return data.toMap();
  }
}
