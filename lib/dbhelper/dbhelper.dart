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
          ${AddstudentColumns.batchname} TEXT not null,
          ${AddstudentColumns.studentname} TEXT not null,
          ${AddstudentColumns.studentmobilenumber} TEXT not null,
          ${AddstudentColumns.fathername} TEXT not null,
          ${AddstudentColumns.fathermobilenumber} TEXT not null,
          ${AddstudentColumns.mothername} TEXT not null,
          ${AddstudentColumns.mothermobilenumber} TEXT not null,
          ${AddstudentColumns.fees} TEXT not null,
          ${AddstudentColumns.currenttime} TEXT not null,
          ${AddstudentColumns.dateOfBirth} TEXT not null,
          ${AddstudentColumns.isActive} BOOL
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
          ${AddCoachColumns.name} TEXT not null,
          ${AddCoachColumns.mobile} TEXT not null,
          ${AddCoachColumns.salary} TEXT not null,
          ${AddCoachColumns.bankDetails} TEXT not null,
          ${AddCoachColumns.dateOfJoining} TEXT not null,
          ${AddCoachColumns.dateOfResignation} TEXT not null,
          ${AddCoachColumns.idCardPath} TEXT not null,
          ${AddCoachColumns.bankPassbookPath} TEXT not null
        )
      ''');
    } catch (e) {
      print('Error creating tables: $e');
      throw Exception('Error creating tables');
    }
  }
}
