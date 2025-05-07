/// Represents a user within the application.
///
/// The [User] class holds personal information about an application user,
class User {
  /// The unique username used for login and identification.
  final String username;

  /// The user's password used for authentication.
  final String password;

  /// The user's first name.
  final String firstName;

  /// The user's last name.
  final String lastName;

  /// Optional path to the user's profile image.
  ///
  /// This can be a local or remote path. It may be `null` if no image is provided.
  final String? profileImagePath;

  /// The user's date of birth, typically in ISO 8601 string format (e.g., 'YYYY-MM-DD').
  final String birthday;

  /// Creates a [User] instance with the given required and optional parameters.
  ///
  /// The [username], [password], [firstName], [lastName], and [birthday] must be provided.
  /// The [profileImagePath] is optional.
  User({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.profileImagePath,
    required this.birthday,
  });

  /// Returns a copy of this [User] object with optional new values for its fields.
  ///
  /// Only the specified parameters will be updated. All other values remain unchanged.
  User copyWith({
    final String? newUsername,
    final String? newPassword,
    final String? newFirstName,
    final String? newLastName,
    final String? newProfileImagePath,
  }) {
    return User(
      username: newUsername ?? username,
      password: newPassword ?? password,
      firstName: newFirstName ?? firstName,
      lastName: newLastName ?? lastName,
      profileImagePath: newProfileImagePath ?? profileImagePath,
      birthday: birthday,
    );
  }

  /// Converts this [User] instance into a map of key-value pairs.
  ///
  /// Useful for database operations or serialization.
  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "referenceProfileImage": profileImagePath,
      "birthday": birthday,
    };
  }

  /// Creates a [User] instance from a given [map].
  ///
  /// This method converts a map of key-value pairs into a [User] object.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map["username"] as String,
      password: map["password"] as String,
      firstName: map["firstName"] as String,
      lastName: map["lastName"] as String,
      profileImagePath: map["referenceProfileImage"] as String?,
      birthday: map["birthday"] as String,
    );
  }
}
