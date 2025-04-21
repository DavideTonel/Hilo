enum AffectType {
  positive(value: "positive"),
  negative(value: "negative");

  final String value;

  const AffectType({required this.value});

  factory AffectType.fromString(String value) {
    return AffectType.values.firstWhere(
      (type) => type.value == value,
    );
  }
}
