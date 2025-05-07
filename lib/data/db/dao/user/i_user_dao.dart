import 'package:roadsyouwalked_app/model/authentication/user.dart';

/// Interface for accessing users stored in the database.
abstract class IUserDao {
  /// Checks if a user exists with the specified username and password.
  ///
  /// [username] - The username to check for.
  /// [password] - The password to check for.
  ///
  /// Returns `true` if a user with the given username and password exists, otherwise `false`.
  Future<bool> checkUserExists(final String username, final String password);

  /// Validates if the provided username is available for registration.
  ///
  /// [username] - The username to validate.
  ///
  /// Returns `true` if the username is available (not already taken), otherwise `false`.
  Future<bool> isValidUsername(final String username);

  /// Creates a new user in the database.
  ///
  /// [user] - A `User` object containing the details of the user to be created.
  ///
  /// Returns `true` if the user was successfully created, otherwise `false`.
  Future<bool> createUser(final User user);

  /// Retrieves user data by username and password.
  ///
  /// [username] - The username to search for.
  /// [password] - The password to search for.
  ///
  /// Returns a list of `User` objects that match the given username and password.
  Future<List<User>> getUser(final String username, final String password);

  /// Updates the user's profile image path.
  ///
  /// [username] - The username of the user whose profile image needs to be updated.
  /// [newImagePath] - The new image path to be set. Can be `null` if the image is to be removed.
  Future<void> updateProfileImageUser(final String username, final String? newImagePath);
}