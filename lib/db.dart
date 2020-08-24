import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

const String databaseName = 'test.db';

class BMIData {
  int _id;
  double _bmi;
  String _date;

  BMIData(int id, double bmi) {
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