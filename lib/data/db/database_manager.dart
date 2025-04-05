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
      join(await getDatabasesPath(), "uni_test_4.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          """
            CREATE TABLE User(
              username TEXT PRIMARY KEY,
              password TEXT NOT NULL,
              firstName TEXT NOT NULL,
              lastName TEXT NOT NULL
            );
          """
        );
        await db.execute(
          """
            CREATE TABLE Memory (
              id TEXT NOT NULL,
              creatorId TEXT NOT NULL,
              timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
              PRIMARY KEY (id, creatorId),
              FOREIGN KEY (creatorId) REFERENCES User(username) ON DELETE CASCADE
            );
          """
        );
        await db.execute(
          """
            CREATE TABLE Media (
              id TEXT PRIMARY KEY,
              creatorId TEXT,
              memoryId TEXT,
              sourceType TEXT NOT NULL CHECK (sourceType IN ('local', 'remote', 'cloud')),
              type TEXT NOT NULL CHECK (type IN ('image', 'video', 'audio', 'document')),
              reference TEXT NOT NULL,
              FOREIGN KEY (memoryId, creatorId) REFERENCES Memory(id, creatorId) ON DELETE CASCADE,
              CHECK (
                (memoryId IS NOT NULL AND creatorId IS NOT NULL) OR 
                (memoryId IS NULL AND creatorId IS NULL)
              )
            );
          """
        );
      }
    );
  }

  // TODO: use close method
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
