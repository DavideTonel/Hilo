import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  static final DatabaseManager instance = DatabaseManager._init();
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initializeDB();
    return _db!;
  }

  DatabaseManager._init();

  Future<Database> initializeDB() async {
    return openDatabase(
      join(await getDatabasesPath(), "test__3.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
        """
          CREATE TABLE User(
            username TEXT PRIMARY KEY,
            password TEXT NOT NULL,
            firstName TEXT NOT NULL,
            lastName TEXT NOT NULL
          )
        """
        );

        await db.execute(
        """
          CREATE TABLE Memory(
            id TEXT PRIMARY KEY,
            timestamp INTEGER NOT NULL,
            creatorId TEXT NOT NULL,
            description TEXT,
            FOREIGN KEY (creatorId) REFERENCES User(username) ON DELETE CASCADE
          )
        """
        );
      }
    );
  }
}
// TODO: add close method
