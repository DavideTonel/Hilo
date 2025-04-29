enum ThemeLight {
  light(value: "light"),
  dark(value: "dark"),
  system(value: "system");

  final String value;

  const ThemeLight({required this.value});

  factory ThemeLight.fromString(String value) {
    return ThemeLight.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ThemeLight.system,
    );
  }
}
