import 'dart:io';
import 'dart:developer' as dev;
import 'package:roadsyouwalked_app/data/db/dao/user_dao.dart';
import 'package:roadsyouwalked_app/data/storage/media_storage_service.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';
import 'package:roadsyouwalked_app/data/shared_preferences/shared_preferences_manager.dart';
import 'package:roadsyouwalked_app/model/media/media.dart';
import 'package:roadsyouwalked_app/model/media/media_type.dart';
import 'package:roadsyouwalked_app/model/media/pending_media.dart';

class UserRepository {
  final UserDao _userDao = UserDao();
  final SharedPreferencesManager _sharedPreferencesManager =
      SharedPreferencesManager.instance;
  final _mediaStorageService = MediaStorageService();

  Future<bool> checkUserExists(
    final String username,
    final String password,
  ) async {
    return await _userDao.checkUserExists(username, password);
  }

  Future<bool> isValidUsername(final String username) async {
    return await _userDao.isValidUsername(username);
  }

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

  Future<User?> getUser(final String username, final String password) async {
    final List<User> users = await _userDao.getUser(username, password);
    return users.first;
  }

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
    dev.log("Update fatto su repo");
  }

  Future<Map<String, String>?> getAutoLoginCredentials() async {
    return _sharedPreferencesManager.getMap(["username", "password"]).then((
      map,
    ) {
      if (map != null) {
        return map.map((key, value) => MapEntry(key, value as String));
      } else {
        return null;
      }
    });
  }

  Future<void> setAutoLoginCredentials(
    final String username,
    final String password,
  ) async {
    await _sharedPreferencesManager.setMap({
      "username": username,
      "password": password,
    });
  }

  Future<void> deleteAutoLoginCredentials() async {
    await _sharedPreferencesManager.delete(["username", "password"]);
  }
}
