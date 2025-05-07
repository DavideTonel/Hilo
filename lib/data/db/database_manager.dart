import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// A singleton class that manages the SQLite database lifecycle and schema.
///
/// This class provides access to a persistent local database used to store
/// user data, memories, media files, mood evaluations, and application settings.
class DatabaseManager {
  /// The single instance of [DatabaseManager].
  static final DatabaseManager instance = DatabaseManager._init();

  static Database? _db;

  /// Private constructor for singleton pattern.
  DatabaseManager._init();

  /// Provides a reference to the initialized [Database] instance.
  ///
  /// If the database is not yet initialized, it will be opened and created if necessary.
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initializeDB();
    return _db!;
  }

  /// Initializes the local SQLite database with all required tables and default data.
  Future<Database> initializeDB() async {
    return openDatabase(
      join(await getDatabasesPath(), "uni_test_11.db"),
      version: 1,
      onCreate: (db, version) async {
        // Settings table
        await db.execute("""
          CREATE TABLE Settings(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            themeLight TEXT NOT NULL CHECK (themeLight IN ('dark', 'light', 'system')),
            themeSeedColor TEXT NOT NULL,
            mapStyle TEXT NOT NULL CHECK (mapStyle IN ('dusk', 'dawn', 'day', 'night', 'system'))
          );
        """);

        // User table
        await db.execute("""
          CREATE TABLE User(
            username TEXT PRIMARY KEY,
            password TEXT NOT NULL,
            firstName TEXT NOT NULL,
            lastName TEXT NOT NULL,
            referenceProfileImage TEXT,
            birthday DATETIME NOT NULL
          );
        """);

        // Memory table
        await db.execute("""
          CREATE TABLE Memory (
            id TEXT NOT NULL,
            creatorId TEXT NOT NULL,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
            description TEXT,
            evaluationScaleId TEXT NOT NULL,
            resultJson TEXT NOT NULL,
            latitude REAL,
            longitude REAL,
            PRIMARY KEY (id, creatorId),
            FOREIGN KEY (creatorId) REFERENCES User(username) ON DELETE CASCADE,
            FOREIGN KEY (evaluationScaleId) REFERENCES Evaluation_Scale(id)
          );
        """);

        // Media table
        await db.execute("""
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
        """);

        // Evaluation scale table
        await db.execute("""
          CREATE TABLE Evaluation_Scale (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL
          );
        """);

        // Evaluation scale items
        await db.execute("""
          CREATE TABLE Evaluation_Scale_Item (
            id TEXT NOT NULL,
            evaluationScaleId TEXT NOT NULL,
            label TEXT NOT NULL,
            minValue INTEGER NOT NULL,
            maxValue INTEGER NOT NULL,
            affectType TEXT CHECK (affectType IN ('positive', 'negative')),
            PRIMARY KEY (id, evaluationScaleId),
            FOREIGN KEY (evaluationScaleId) REFERENCES Evaluation_Scale(id) ON DELETE CASCADE,
            CHECK (minValue < maxValue)
          );
        """);

        // Evaluation results
        await db.execute("""
          CREATE TABLE Evaluation_Result_Item (
            memoryId TEXT NOT NULL,
            creatorId TEXT NOT NULL,
            evaluationScaleItemId TEXT NOT NULL,
            evaluationScaleId TEXT NOT NULL,
            score INTEGER NOT NULL,
            PRIMARY KEY (memoryId, creatorId, evaluationScaleItemId, evaluationScaleId),
            FOREIGN KEY (memoryId, creatorId) REFERENCES Memory(id, creatorId) ON DELETE CASCADE,
            FOREIGN KEY (evaluationScaleItemId, evaluationScaleId) REFERENCES Evaluation_Scale_Item(id, evaluationScaleId) ON DELETE CASCADE
          );
        """);

        // Insert PANAS Short Form scale
        await db.insert("Evaluation_Scale", {
          "id": "panas_sf",
          "name": "PANAS Short Form",
        });

        // Positive affect items
        await db.insert("Evaluation_Scale_Item", {
          "id": "1",
          "evaluationScaleId": "panas_sf",
          "label": "Interested",
          "minValue": 1,
          "maxValue": 5,
          "affectType": "positive",
        });
        await db.insert("Evaluation_Scale_Item", {
          "id": "2",
          "evaluationScaleId": "panas_sf",
          "label": "Excited",
          "minValue": 1,
          "maxValue": 5,
          "affectType": "positive",
        });
        await db.insert("Evaluation_Scale_Item", {
          "id": "3",
          "evaluationScaleId": "panas_sf",
          "label": "Strong",
          "minValue": 1,
          "maxValue": 5,
          "affectType": "positive",
        });
        await db.insert("Evaluation_Scale_Item", {
          "id": "4",
          "evaluationScaleId": "panas_sf",
          "label": "Enthusiastic",
          "minValue": 1,
          "maxValue": 5,
          "affectType": "positive",
        });
        await db.insert("Evaluation_Scale_Item", {
          "id": "5",
          "evaluationScaleId": "panas_sf",
          "label": "Inspired",
          "minValue": 1,
          "maxValue": 5,
          "affectType": "positive",
        });

        // Negative affect items
        await db.insert("Evaluation_Scale_Item", {
          "id": "6",
          "evaluationScaleId": "panas_sf",
          "label": "Afraid",
          "minValue": 1,
          "maxValue": 5,
          "affectType": "negative",
        });
        await db.insert("Evaluation_Scale_Item", {
          "id": "7",
          "evaluationScaleId": "panas_sf",
          "label": "Upset",
          "minValue": 1,
          "maxValue": 5,
          "affectType": "negative",
        });
        await db.insert("Evaluation_Scale_Item", {
          "id": "8",
          "evaluationScaleId": "panas_sf",
          "label": "Hostile",
          "minValue": 1,
          "maxValue": 5,
          "affectType": "negative",
        });
        await db.insert("Evaluation_Scale_Item", {
          "id": "9",
          "evaluationScaleId": "panas_sf",
          "label": "Nervous",
          "minValue": 1,
          "maxValue": 5,
          "affectType": "negative",
        });
        await db.insert("Evaluation_Scale_Item", {
          "id": "10",
          "evaluationScaleId": "panas_sf",
          "label": "Ashamed",
          "minValue": 1,
          "maxValue": 5,
          "affectType": "negative",
        });
      },
    );
  }
}
