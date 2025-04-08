enum AffectType {
  positive(value: "positve"),
  negative(value: "negative"),
  neutral(value: "neutral");

  final String value;

  const AffectType({required this.value});
}
