import 'package:badmiton_app/dbmodel/addstudentmodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../dbmodel/batchmodel.dart';
import '../dbmodel/coachmodel.dart';

class DBHelper {
  static Database? _db;

  static Future<Database?> getInstance() async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  static Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'Badminton.db');
    try {
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
    } catch (e) {
      print('Error opening database: $e');
      return Future.error('Error opening database');
    }
  }

  static void _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE $addstudentName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          ${AddstudentColumns.batchname} TEXT,
          ${AddstudentColumns.studentname} TEXT,
          ${AddstudentColumns.studentmobilenumber} TEXT,
          ${AddstudentColumns.fathername} TEXT,
          ${AddstudentColumns.fathermobilenumber} TEXT,
          ${AddstudentColumns.mothername} TEXT,
          ${AddstudentColumns.mothermobilenumber} TEXT,
          ${AddstudentColumns.fees} TEXT,
          ${AddstudentColumns.currenttime} TEXT,
          ${AddstudentColumns.dateOfBirth} TEXT,
          ${AddstudentColumns.isActive} BOOL,
          ${AddstudentColumns.isPresent} BOOL
        )
      ''');

      await db.execute('''
         CREATE TABLE $batchtablename(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          ${AddBatchColumns.name} TEXT ,
          ${AddBatchColumns.description} TEXT ,
          ${AddBatchColumns.fees} DECIMAL ,
          ${AddBatchColumns.batchDays} TEXT ,
          ${AddBatchColumns.time} TEXT ,
          ${AddBatchColumns.studentIntake} TEXT ,
          ${AddBatchColumns.isActive} BOOL
        )
      ''');

      await db.execute('''
        CREATE TABLE ${AddCoachColumns.tableName}(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          ${AddCoachColumns.name} TEXT,
          ${AddCoachColumns.mobile} TEXT,
          ${AddCoachColumns.salary} TEXT,
          ${AddCoachColumns.bankDetails} TEXT,
          ${AddCoachColumns.dateOfJoining} TEXT,
          ${AddCoachColumns.dateOfResignation} TEXT,
          ${AddCoachColumns.idCardPath} TEXT,
          ${AddCoachColumns.bankPassbookPath} TEXT
        )
      ''');
    } catch (e) {
      print('Error creating tables: $e');
      throw Exception('Error creating tables');
    }
  }

  Future<void> createTables(Database db) async {
    await db.execute('''
    CREATE TABLE ${AddCoachColumns.tableName} (
      ${AddCoachColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${AddCoachColumns.name} TEXT,
      ${AddCoachColumns.mobile} TEXT,
      ${AddCoachColumns.salary} TEXT,
      ${AddCoachColumns.bankDetails} TEXT,
      ${AddCoachColumns.dateOfJoining} TEXT,
      ${AddCoachColumns.dateOfResignation} TEXT,
      ${AddCoachColumns.idCardPath} TEXT,
      ${AddCoachColumns.bankPassbookPath} TEXT
    )
  ''');
  }
}
