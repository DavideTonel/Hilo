class IncompleteMemoryException implements Exception {
  final String message;
  IncompleteMemoryException([this.message = "Memory is empty"]);

  @override
  String toString() => "IncompleteMemoryException: $message";
}
