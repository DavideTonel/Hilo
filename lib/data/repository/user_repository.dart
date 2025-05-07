import 'dart:io';
import 'package:roadsyouwalked_app/data/db/dao/user_dao.dart';
import 'package:roadsyouwalked_app/data/storage/media_storage_service.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';
import 'package:roadsyouwalked_app/data/shared_preferences/shared_preferences_manager.dart';
import 'package:roadsyouwalked_app/model/media/media.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';

/// A repository class for managing user-related data and operations.
class UserRepository {
  final UserDao _userDao = UserDao();
  final SharedPreferencesManager _sharedPreferencesManager =
      SharedPreferencesManager.instance;
  final _mediaStorageService = MediaStorageService();

  /// Checks if a user exists based on the provided username and password.
  ///
  /// This method verifies if a user with the given username and password
  /// exists in the database.
  ///
  /// [username] - The username of the user.
  /// [password] - The password of the user.
  ///
  /// Returns `true` if the user exists, otherwise `false`.
  Future<bool> checkUserExists(
    final String username,
    final String password,
  ) async {
    return await _userDao.checkUserExists(username, password);
  }

  /// Validates if the provided username is valid.
  ///
  /// This method checks if the provided username meets the criteria for
  /// being valid.
  ///
  /// [username] - The username to validate.
  ///
  /// Returns `true` if the username is valid, otherwise `false`.
  Future<bool> isValidUsername(final String username) async {
    return await _userDao.isValidUsername(username);
  }

  /// Creates a new user and saves their data to the database.
  ///
  /// If the user has a profile image, it is saved
  /// before updating the user data in the database.
  ///
  /// [user] - The user to create.
  ///
  /// Returns `true` if the user was successfully created, otherwise `false`.
  Future<bool> createUser(User user) async {
    if (user.profileImagePath != null) {
      final Media profileImage = await _mediaStorageService.saveMedia(
        PendingMedia(
          id:
              "${user.username}_profile_img_${DateTime.now().millisecondsSinceEpoch}",
          type: MediaType.image,
          localFile: File(user.profileImagePath!),
          creatorId: user.username,
        ),
      );
      user = user.copyWith(newProfileImagePath: profileImage.reference);
    }
    return await _userDao.createUser(user);
  }

  /// Retrieves a user from the database based on the provided username and password.
  ///
  /// [username] - The username of the user.
  /// [password] - The password of the user.
  ///
  /// Returns the user if found, otherwise returns `null`.
  Future<User?> getUser(final String username, final String password) async {
    final List<User> users = await _userDao.getUser(username, password);
    return users.isEmpty ? null : users.first;
  }

  /// Updates the profile image of an existing user.
  ///
  /// If a new image is provided, it is saved and
  /// the user's profile image path is updated in the database.
  ///
  /// [username] - The username of the user whose profile image is being updated.
  /// [newImage] - The new profile image file.
  ///
  /// Throws an exception if there is an issue saving the image.
  Future<void> updateProfileImage(
    final String username,
    final File? newImage,
  ) async {
    String? newPath;
    if (newImage != null) {
      final Media profileImage = await _mediaStorageService.saveMedia(
        PendingMedia(
          id: "${username}_profile_img_${DateTime.now().millisecondsSinceEpoch}",
          type: MediaType.image,
          localFile: newImage,
          creatorId: username,
        ),
      );
      newPath = profileImage.reference;
    }
    await _userDao.updateProfileImageUser(username, newPath);
  }

  /// Retrieves the stored auto-login credentials.
  ///
  /// This method retrieves the username and password stored for auto-login.
  ///
  /// Returns a `Map<String, String>` containing the username and password, or `null`
  /// if the credentials are not found.
  Future<Map<String, String>?> getAutoLoginCredentials() async {
    return _sharedPreferencesManager.getMap(["username", "password"]).then((map) {
      if (map != null) {
        return map.map((key, value) => MapEntry(key, value as String));
      } else {
        return null;
      }
    });
  }

  /// Saves the provided username and password for auto-login.
  ///
  /// [username] - The username to save.
  /// [password] - The password to save.
  Future<void> setAutoLoginCredentials(
    final String username,
    final String password,
  ) async {
    await _sharedPreferencesManager.setMap({
      "username": username,
      "password": password,
    });
  }

  /// Deletes the stored auto-login credentials.
  Future<void> deleteAutoLoginCredentials() async {
    await _sharedPreferencesManager.delete(["username", "password"]);
  }
}
