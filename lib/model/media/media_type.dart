/// Enum representing the different types of media.
///
/// This enum categorizes media based on its type, such as image, video, audio, document,
/// or unknown. It provides a way to handle media files according to their specific type.
enum MediaType {
  /// Represents a media file of type image.
  image("image"),

  /// Represents a media file of type video.
  video("video"),

  /// Represents a media file of type audio.
  audio("audio"),

  /// Represents a media file of type document.
  document("document"),

  /// Represents a media file with an unknown or undefined type.
  unknown("unknown");

  final String value;

  /// Constructor to initialize the [MediaType] with a string value.
  const MediaType(this.value);

  /// Factory method to create a [MediaType] from a string value.
  ///
  /// This method attempts to match the given [value] with a corresponding [MediaType].
  /// If no match is found, it defaults to [MediaType.unknown].
  ///
  /// [value] The string representation of the media type.
  ///
  /// Returns the corresponding [MediaType] or [MediaType.unknown] if no match is found.
  factory MediaType.fromString(String value) {
    return MediaType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => MediaType.unknown,
    );
  }
}
