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
      join(await getDatabasesPath(), "uni_test_5.db"),
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
              description TEXT,
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
        await db.execute(
          """
            CREATE TABLE Evaluation_Scale (
              id TEXT PRIMARY KEY,
              name TEXT NOT NULL
            );
          """
        );
        await db.execute(
          """
            CREATE TABLE Evaluation_Scale_Item (
              id TEXT NOT NULL,
              scaleId TEXT NOT NULL,
              label TEXT NOT NULL,
              minValue INTEGER NOT NULL,
              maxValue INTEGER NOT NULL,
              affectType TEXT CHECK (affectType IN ('positive', 'negative')),
              PRIMARY KEY (id, scaleId),
              FOREIGN KEY (scaleId) REFERENCES Evaluation_Scale(id) ON DELETE CASCADE,
              CHECK (minValue < maxValue)
            );
          """
        );
        await db.execute(
          """
            CREATE TABLE Evaluation (
              id TEXT NOT NULL,
              creatorId TEXT NOT NULL,
              scaleId TEXT NOT NULL,
              timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
              PRIMARY KEY (id, creatorId),
              FOREIGN KEY (creatorId) REFERENCES User(username) ON DELETE CASCADE,
              FOREIGN KEY (scaleId) REFERENCES Evaluation_Scale(id)
            );
          """
        );
        await db.execute(
          """
            CREATE TABLE Evaluation_Result (
              evaluationId TEXT NOT NULL,
              creatorId TEXT NOT NULL,
              label TEXT NOT NULL,
              value INTEGER NOT NULL,
              PRIMARY KEY (evaluationId, creatorId, label),
              FOREIGN KEY (evaluationId, creatorId) REFERENCES Evaluation(id, creatorId) ON DELETE CASCADE
            );
          """
        );
        await db.execute(
          """
            CREATE TABLE Item_In_Evaluation (
              evaluationId TEXT NOT NULL,
              creatorId TEXT NOT NULL,
              scaleId TEXT NOT NULL,
              scaleItemId TEXT NOT NULL,
              score INTEGER NOT NULL,
              PRIMARY KEY (evaluationId, creatorId, scaleId, scaleItemId),
              FOREIGN KEY (evaluationId) REFERENCES Evaluation(id),
              FOREIGN KEY (creatorId) REFERENCES User(username),
              FOREIGN KEY (scaleId) REFERENCES Evaluation_Scale(id),
              FOREIGN KEY (scaleItemId, scaleId) REFERENCES Evaluation_Scale_Item(id, scaleId)
            );
          """
        );

        await db.insert(
          "Evaluation_Scale",
          {
            "id": "panas_sf",
            "name": "PANAS Short Form",
          }
        );
        await db.insert(
          "Evaluation_Scale_Item",
          {
            "id": "1",
            "scaleId": "panas_sf",
            "label": "Interested",
            "minValue": 1,
            "maxValue": 5,
            "affectType": "positive",
          }
        );
        await db.insert(
          "Evaluation_Scale_Item",
          {
            "id": "2",
            "scaleId": "panas_sf",
            "label": "Upset",         // TODO: put right items with right ids
            "minValue": 1,
            "maxValue": 5,
            "affectType": "negative",
          }
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
