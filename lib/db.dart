import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'package:sqflite/sql.dart';

/// Data model for querying bmi database.
class BMILog {
  int _id;
  double _bmi;
  String _date;

  BMILog(int id, double bmi) {
    _id = id;
    _bmi = bmi;
    _date = DateTime.now().toIso8601String();
  }

  BMILog.fetch(this._id, this._bmi, this._date);

  get id => _id;

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'bmi': _bmi,
      'date': _date
    };
  }
}

/// Query system that allows the user to store/retrieve bmi logs
class BMIDatabaseQuerySystem {
  static final BMIDatabaseQuerySystem _singleton = BMIDatabaseQuerySystem._internal();
  static const String _databaseName = 'test.db';
  static const String _tableName = 'bmilogs';
  Database _database;

  factory BMIDatabaseQuerySystem() => _singleton;

  BMIDatabaseQuerySystem._internal() {
    _startDb();
  }

  void _startDb() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) => db.execute('CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, bmi REAL, date TEXT)'),
      version: 1
    );
  }

  Future<void> insertBMILog(BMILog log) async {
    await _database.insert(
      _tableName,
      log.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<BMILog>> getBMILogs() async {
    List<Map<String, dynamic>> maps = await _database.query(_tableName);
    return List.generate(maps.length, (i) => BMILog.fetch(
      maps[i]['id'],
      maps[i]['bmi'],
      maps[i]['date']
    ));
  }

  Future<void> updateBMILog(BMILog log) async {
    await _database.update(
      _tableName,
      log.toMap(),
      where: 'id = ?',
      whereArgs: [log.id]
    );
  }
}