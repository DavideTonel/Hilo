import 'package:roadsyouwalked_app/db/user/user_dao.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';

class UserRepository {
  final UserDao _userDao = UserDao();

  Future<bool> checkUserExists(final String username, final String password) async {
    return await _userDao.checkUserExists(username, password);
  }

  Future<bool> isValidUsername(final String username) async {
    return await _userDao.isValidUsername(username);
  }

  Future<bool> createUser(final User user) async {
    return await _userDao.createUser(user);
  }
}