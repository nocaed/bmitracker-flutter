import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

/// Data model for querying bmi database.
class BMILog {
  // primary key
  int _id;
  // user bmi
  double _bmi;
  // date of the log
  String _date;

  /// Default constructor that is used when creating a new log for insertion.
  BMILog(int id, double bmi) {
    _id = id;
    _bmi = bmi;
    _date = DateTime.now().toIso8601String();
  }

  /// Constructor used for retrieval from a database.
  BMILog.fetch(this._id, this._bmi, this._date);

  /// Access for primary key.
  get id => _id;

  /// Converts instance of BMILog to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'bmi': _bmi,
      'date': _date
    };
  }
}

/// Query system that allows the user to store/retrieve bmi logs.
///
/// This class is designed with the singleton design pattern as only a single
/// instance is needed for querying.
class BMIDatabaseQuerySystem {
  // The instance of the query system
  static final BMIDatabaseQuerySystem _singleton = BMIDatabaseQuerySystem._internal();
  // The file name of the database that is being queried
  static const String _databaseName = 'test.db';
  // The table name of the bmi logs
  static const String _tableName = 'bmilogs';
  // The database instance
  Future<Database> _database;

  /// Default constructor for the query system.
  factory BMIDatabaseQuerySystem() => _singleton;

  // Singleton constructor, starts the database
  BMIDatabaseQuerySystem._internal() {
    _startDb();
  }

  // Helper function that starts the database asynchronously
  void _startDb() async {
    _database = openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) => db.execute('CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, bmi REAL, date TEXT)'),
      version: 1
    );
  }

  /// Inserts a new bmi log into the database.
  Future<void> insertBMILog(BMILog log) async {
    var db = await _database;
    await db.insert(
      _tableName,
      log.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  /// Retrieves all bmi logs from the database.
  Future<List<BMILog>> getBMILogs() async {
    var db = await _database;
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) => BMILog.fetch(
      maps[i]['id'],
      maps[i]['bmi'],
      maps[i]['date']
    ));
  }

  /// Updates a target bmi log in the database.
  Future<void> updateBMILog(BMILog log) async {
    var db = await _database;
    await db.update(
      _tableName,
      log.toMap(),
      where: 'id = ?',
      whereArgs: [log.id]
    );
  }

  /// Deletes a target bmi log in the database.
  Future<void> deleteBMILog(int id) async {
    var db = await _database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}