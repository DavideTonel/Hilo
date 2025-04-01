import 'package:roadsyouwalked_app/db/user/user_dao.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';
import 'package:roadsyouwalked_app/shared_preferences/shared_preferences_manager.dart';

class UserRepository {
  final UserDao _userDao = UserDao();
  final SharedPreferencesManager _sharedPreferencesManager = SharedPreferencesManager.instance;

  Future<bool> checkUserExists(final String username, final String password) async {
    return await _userDao.checkUserExists(username, password);
  }

  Future<bool> isValidUsername(final String username) async {
    return await _userDao.isValidUsername(username);
  }

  Future<bool> createUser(final User user) async {
    return await _userDao.createUser(user);
  }

  Future<User?> getUser(final String username, final String password) async {
    final List<User> users = await _userDao.getUser(username, password);
    return users.first;
  }

  Future<Map<String, String>?> getAutoLoginCredentials() async {
    return _sharedPreferencesManager.getMap(["username", "password"]).then((map) {
      if (map != null) {
        return map.map((key, value) => MapEntry(key, value as String));
      } else {
        return null;
      }
    });
  }

  Future<void> setAutoLoginCredentials(final String username, final String password) async {
    await _sharedPreferencesManager.setMap({
      "username": username,
      "password": password,
    });
  }

  Future<void> deleteAutoLoginCredentials() async {
    await _sharedPreferencesManager.delete(["username", "password"]);
  }
}