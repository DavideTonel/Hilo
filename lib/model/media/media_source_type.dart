enum MediaSourceType {
  local("local"),
  remote("remote"),
  cloud("cloud"),
  unknown("unknown");

  final String value;
  const MediaSourceType(this.value);

  factory MediaSourceType.fromString(String value) {
    return MediaSourceType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => MediaSourceType.unknown,
    );
  }
}
