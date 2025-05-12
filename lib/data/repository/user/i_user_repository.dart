import 'dart:io';

import 'package:roadsyouwalked_app/model/authentication/user.dart';

/// Interface for managing user-related data.
abstract class IUserRepository {
  /// Checks if a user exists based on the provided username and password.
  ///
  /// [username] - The username of the user.
  /// [password] - The password of the user.
  ///
  /// Returns `true` if the user exists, otherwise `false`.
  Future<bool> checkUserExists(final String username, final String password);

  /// Validates if the provided username is valid.
  ///
  /// This method checks if the provided username meets the criteria for
  /// being valid.
  ///
  /// [username] - The username to validate.
  ///
  /// Returns `true` if the username is valid, otherwise `false`.
  Future<bool> isValidUsername(final String username);

  /// Creates a new user and saves their data to the database.
  ///
  /// [user] - The user to create.
  ///
  /// Returns `true` if the user was successfully created, otherwise `false`.
  Future<bool> createUser(User user);

  /// Retrieves a user from the database based on the provided username and password.
  ///
  /// [username] - The username of the user.
  /// [password] - The password of the user.
  ///
  /// Returns the user if found, otherwise returns `null`.
  Future<User?> getUser(final String username, final String password);

  /// Updates the profile image of an existing user.
  ///
  /// [username] - The username of the user whose profile image is being updated.
  /// [newImage] - The new profile image file.
  ///
  /// Throws an exception if there is an issue saving the image.
  Future<void> updateProfileImage(final String username, final File? newImage);

  /// Updates the existing user data.
  ///
  /// [user] - The user with new data.
  Future<void> updateUser(User user);

  /// Retrieves the stored auto-login credentials.
  ///
  /// This method retrieves the username and password stored for auto-login.
  ///
  /// Returns a `Map<String, String>` containing the username and password, or `null`
  /// if the credentials are not found.
  Future<Map<String, String>?> getAutoLoginCredentials();

  /// Saves the provided username and password for auto-login.
  ///
  /// [username] - The username to save.
  /// [password] - The password to save.
  Future<void> setAutoLoginCredentials(
    final String username,
    final String password,
  );

  /// Deletes the stored auto-login credentials.
  Future<void> deleteAutoLoginCredentials();
}
