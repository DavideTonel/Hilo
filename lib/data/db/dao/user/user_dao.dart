import 'dart:developer' as dev;
import 'package:roadsyouwalked_app/data/db/dao/user/i_user_dao.dart';
import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';
import 'package:sqflite/sqflite.dart';

/// Data Access Object (DAO) class for managing user-related operations in the database.
/// Concrete implementation of [IUserDao].
class UserDao extends IUserDao {
  // Instance of the DatabaseManager for accessing the database.
  final DatabaseManager _dbManager = DatabaseManager.instance;

  @override
  Future<bool> checkUserExists(final String username, final String password) async {
    try {
      final db = await _dbManager.database;
      final List<Map<String, dynamic>> result = await db.query(
        "User",
        where: "username = ? AND password = ?",
        whereArgs: [username, password],
      );
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> isValidUsername(final String username) async {
    try {
      final db = await _dbManager.database;
      final List<Map<String, dynamic>> result = await db.query(
        "User",
        where: "username = ?",
        whereArgs: [username],
      );
      return result.isEmpty;
    } catch (e) {
      dev.log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> createUser(final User user) async {
    try {
      final db = await _dbManager.database;
      await db.insert(
        "User",
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );
      return true;
    } catch (e) {
      dev.log(e.toString());
      return false;
    }
  }

  @override
  Future<List<User>> getUser(final String username, final String password) async {
    try {
      final db = await _dbManager.database;
      final List<Map<String, dynamic>> result = await db.query(
        "User",
        where: "username = ? AND password = ?",
        whereArgs: [username, password],
      );
      return result.map((elem) => User.fromMap(elem)).toList();
    } catch (e) {
      dev.log(e.toString());
      return [];
    }
  }

  @override
  Future<void> updateProfileImageUser(final String username, final String? newImagePath) async {
    try {
      final db = await _dbManager.database;
      await db.update(
        "User",
        {
          "referenceProfileImage": newImagePath
        },
        where: "username = ?",
        whereArgs: [ username ]
      );
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
