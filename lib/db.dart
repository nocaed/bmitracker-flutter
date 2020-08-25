import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

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

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'bmi': _bmi,
      'date': _date
    };
  }
}

class BMIDatabaseQuerySystem {
  static final BMIDatabaseQuerySystem _singleton = BMIDatabaseQuerySystem._internal();
  static const String _databaseName = 'test.db';
  Database _database;

  factory BMIDatabaseQuerySystem() => _singleton;

  BMIDatabaseQuerySystem._internal() {
    _startDb();
  }

  void _startDb() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) => db.execute('CREATE TABLE bmilogs(id INTEGER PRIMARY KEY, bmi REAL, date TEXT)'),
      version: 1
    );
  }

  Future<void> insertBMI(BMILog log) async {
    await _database.insert(
      'bmilogs',
      log.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
}