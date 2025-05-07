import 'dart:io';
import 'package:roadsyouwalked_app/data/db/dao/user/i_user_dao.dart';
import 'package:roadsyouwalked_app/data/db/dao/user/user_dao.dart';
import 'package:roadsyouwalked_app/data/repository/user/i_user_repository.dart';
import 'package:roadsyouwalked_app/data/storage/i_media_storage_service.dart';
import 'package:roadsyouwalked_app/data/storage/media_storage_service.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';
import 'package:roadsyouwalked_app/data/shared_preferences/shared_preferences_manager.dart';
import 'package:roadsyouwalked_app/model/media/media.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';

/// A repository class for managing user-related data and operations.
/// /// A concrete implementation of [IUserRepository].
class UserRepository extends IUserRepository {
  final IUserDao _userDao = UserDao();
  final SharedPreferencesManager _sharedPreferencesManager =
      SharedPreferencesManager.instance;
  final IMediaStorageService _mediaStorageService = MediaStorageService();

  @override
  Future<bool> checkUserExists(
    final String username,
    final String password,
  ) async {
    return await _userDao.checkUserExists(username, password);
  }

  @override
  Future<bool> isValidUsername(final String username) async {
    return await _userDao.isValidUsername(username);
  }

  @override
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

  @override
  Future<User?> getUser(final String username, final String password) async {
    final List<User> users = await _userDao.getUser(username, password);
    return users.isEmpty ? null : users.first;
  }

  @override
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

  @override
  Future<Map<String, String>?> getAutoLoginCredentials() async {
    return _sharedPreferencesManager.getMap(["username", "password"]).then((map) {
      if (map != null) {
        return map.map((key, value) => MapEntry(key, value as String));
      } else {
        return null;
      }
    });
  }

  @override
  Future<void> setAutoLoginCredentials(
    final String username,
    final String password,
  ) async {
    await _sharedPreferencesManager.setMap({
      "username": username,
      "password": password,
    });
  }

  @override
  Future<void> deleteAutoLoginCredentials() async {
    await _sharedPreferencesManager.delete(["username", "password"]);
  }
}
