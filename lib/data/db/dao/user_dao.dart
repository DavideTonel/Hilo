import 'dart:developer' as dev;
import 'package:roadsyouwalked_app/data/db/database_manager.dart';
import 'package:roadsyouwalked_app/model/authentication/user.dart';
import 'package:sqflite/sqflite.dart';

/// Data Access Object (DAO) class for managing user-related operations in the database.
class UserDao {
  // Instance of the DatabaseManager for accessing the database.
  final DatabaseManager _dbManager = DatabaseManager.instance;

  /// Checks if a user exists with the specified username and password.
  ///
  /// This method queries the "User" table to see if any record matches the provided
  /// username and password combination.
  ///
  /// [username] - The username to check for.
  /// [password] - The password to check for.
  ///
  /// Returns `true` if a user with the given username and password exists, otherwise `false`.
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

  /// Validates if the provided username is available for registration.
  ///
  /// This method queries the "User" table to check if the specified username is already taken.
  ///
  /// [username] - The username to validate.
  ///
  /// Returns `true` if the username is available (not already taken), otherwise `false`.
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

  /// Creates a new user in the database.
  ///
  /// This method inserts a new user into the "User" table with the provided user data.
  ///
  /// [user] - A `User` object containing the details of the user to be created.
  ///
  /// Returns `true` if the user was successfully created, otherwise `false`.
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

  /// Retrieves user data by username and password.
  ///
  /// This method queries the "User" table to fetch the user details that match the
  /// provided username and password.
  ///
  /// [username] - The username to search for.
  /// [password] - The password to search for.
  ///
  /// Returns a list of `User` objects that match the given username and password.
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

  /// Updates the user's profile image path.
  ///
  /// This method updates the `referenceProfileImage` field of a user in the "User" table
  /// with the provided new image path.
  ///
  /// [username] - The username of the user whose profile image needs to be updated.
  /// [newImagePath] - The new image path to be set. Can be `null` if the image is to be removed.
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
