enum MediaType {
  image("image"),
  video("video"),
  audio("audio"),
  document("document"),
  unknown("unknown");

  final String value;
  const MediaType(this.value);

  factory MediaType.fromString(String value) {
    return MediaType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => MediaType.unknown,
    );
  }
}
