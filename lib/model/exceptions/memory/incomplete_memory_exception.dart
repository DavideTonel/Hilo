/// Custom exception class to handle cases where a memory object is incomplete or empty.
/// This exception is thrown when an operation expects a complete memory but encounters an empty one.
///
/// This class implements the [Exception] interface.
class IncompleteMemoryException implements Exception {
  /// The message to be displayed when the exception is thrown. 
  final String message;

  /// Constructor to create an [IncompleteMemoryException] with an optional custom message.
  IncompleteMemoryException([this.message = "Memory is empty"]);

  /// Returns a string representation of the exception.
  ///
  /// This method is overridden from the [Exception] interface to provide a more meaningful 
  /// message when the exception is printed or logged.
  @override
  String toString() => "IncompleteMemoryException: $message";
}
