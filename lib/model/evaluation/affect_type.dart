/// Represents the type of affect used in mood or psychological assessments.
///
/// This enum is typically used to distinguish between positive and negative
/// emotional states or responses in mood evaluation models.
enum AffectType {
  /// Represents a positive affective state.
  positive(value: "positive"),

  /// Represents a negative affective state.
  negative(value: "negative");

  /// String representation of the affect type.
  final String value;

  /// Creates an [AffectType] with the associated string [value].
  const AffectType({required this.value});

  /// Creates an [AffectType] from a string value.
  ///
  /// Throws a [StateError] if the string does not match any defined type.
  factory AffectType.fromString(String value) {
    return AffectType.values.firstWhere(
      (type) => type.value == value,
    );
  }
}
