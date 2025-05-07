/// Enum representing the different source types for media files.
///
/// This enum categorizes the source of the media, whether it comes from a local file system,
/// a remote server, a cloud storage service, or an unknown source. It provides a way to handle
/// media based on its origin.
enum MediaSourceType {
  /// Represents a media file that originates from the local device storage.
  local("local"),

  /// Represents a media file that comes from a remote server.
  remote("remote"),

  /// Represents a media file that is stored in a cloud storage service.
  cloud("cloud"),

  /// Represents a media file from an unknown or undefined source.
  unknown("unknown");

  final String value;

  /// Constructor to initialize the [MediaSourceType] with a string value.
  const MediaSourceType(this.value);

  /// Factory method to create a [MediaSourceType] from a string value.
  ///
  /// This method attempts to match the given [value] with a corresponding [MediaSourceType].
  /// If no match is found, it defaults to [MediaSourceType.unknown].
  ///
  /// [value] The string representation of the source type.
  ///
  /// Returns the corresponding [MediaSourceType] or [MediaSourceType.unknown] if no match is found.
  factory MediaSourceType.fromString(String value) {
    return MediaSourceType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => MediaSourceType.unknown,
    );
  }
}
