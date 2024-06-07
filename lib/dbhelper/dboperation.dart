import 'dart:developer';

import 'package:badmiton_app/dbmodel/addstudentmodel.dart';
import 'package:badmiton_app/dbmodel/batchmodel.dart';
import 'package:badmiton_app/dbmodel/coachmodel.dart';
import 'package:sqflite/sqflite.dart';

class DBOperation {
  static Future insertBatchTable(Database db, Batchs newbatch) async {
    await db.insert(
      batchtablename, // Ensure this is the correct table name
      newbatch.toMap(), // Convert Batchs object to a Map
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Log the current state of the table after insertion
    final List<Map<String, Object?>> result =
        await db.rawQuery('SELECT * FROM $batchtablename');
    log("BatchTable:::$result");
    return result;
  }

  static Future insertStudentTable(Database db, Addstudent newStudent) async {
    var data = newStudent.toMap();
    log("ItemMasterDBModel len: ${data.length}");
    var batch = db.batch();
    await db.insert(
      addstudentName, // Ensure this is the correct table name
      newStudent.toMap(), // Convert Batchs object to a Map
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // data.forEach((es) async {
    //   batch.insert($addstudentName, es);
    // });
    await batch.commit();

    final List<Map<String, Object?>> result =
        await db.rawQuery('SELECT * FROM $addstudentName');
    log("addstudentName:::${result.toList()}");
    return result;
  }
  // static Future insertStudentTable(Database db, Addstudent newStudent) async {
  //   log('message:::$addstudentName');
  // await db.insert(
  //   addstudentName, // Ensure this is the correct table name
  //   newStudent.toMap(), // Convert Batchs object to a Map
  //   conflictAlgorithm: ConflictAlgorithm.replace,
  // );

  //   // Log the current state of the table after insertion
  // final List<Map<String, Object?>> result =
  //     await db.rawQuery('SELECT * FROM $addstudentName');
  // log("addstudentName:::${result.toList()}");
  // return result;
  // }

  static Future<List<Batchs>> fetchBatches(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query(batchtablename);
    log('results:::${maps.toList()}');
    return List.generate(maps.length, (i) {
      return Batchs(
        id: maps[i][AddBatchColumns.id] as int?,
        name: maps[i][AddBatchColumns.name].toString(),
        description: maps[i][AddBatchColumns.description].toString(),
        fees: double.parse(maps[i][AddBatchColumns.fees].toString()),
        batchDays: (maps[i][AddBatchColumns.batchDays] as String)
            .split(',')
            .map((e) => e == 'true')
            .toList(),
        studentIntake: int.parse(maps[i][AddBatchColumns.studentIntake]),
        time: maps[i][AddBatchColumns.time].toString(),
        isActive: maps[i][AddBatchColumns.isActive] == 'true',
      );
    });
  }

  // static Future<List<Addstudent>> fetchStudents(Database db) async {
  //   final List<Map<String, dynamic>> maps = await db.query(addstudentName);
  //   log('results:::${maps.toList()}');
  //   return List.generate(maps.length, (i) {
  //     final currentTimeString =
  //         maps[i][AddstudentColumns.currenttime].toString();
  //     final timeParts = currentTimeString.split(':');
  //     final currentTime = TimeOfDay(
  //       hour: int.parse(timeParts[0]),
  //       minute: int.parse(timeParts[1]),
  //     );

  //     return Addstudent(
  //       id: maps[i][AddstudentColumns.id] as int?,
  //       studentname: maps[i][AddstudentColumns.studentname].toString(),
  //       studentmobilenumber: int.parse(
  //           maps[i][AddstudentColumns.studentmobilenumber].toString()),
  //       fathername: maps[i][AddstudentColumns.fathername].toString(),
  //       fathermobilenumber:
  //           int.parse(maps[i][AddstudentColumns.fathermobilenumber].toString()),
  //       mothername: maps[i][AddstudentColumns.mothername].toString(),
  //       mothermobilenumber:
  //           int.parse(maps[i][AddstudentColumns.mothermobilenumber].toString()),
  //       currenttime: '${currentTime.hour}:${currentTime.minute}',
  //       fees: int.parse(maps[i][AddstudentColumns.fees].toString()),
  //       dateOfBirth: maps[i][AddstudentColumns.dateOfBirth].toString(),
  //       batchname: maps[i][AddstudentColumns.batchname].toString(),
  //     );
  //   });
  // }
  static Future getBatchList(Database db) async {
    final List<Map<String, Object?>> result = await db
        .rawQuery('SELECT batchname FROM $addstudentName group by batchname');
    log("batchname:::${result.toList()}");
    return result;
  }

  // static Future<List<Addstudent>> fetchStudents(Database db) async {
  //   final List<Map<String, dynamic>> maps = await db.query(addstudentName);
  //   log('results:::${maps.toList()}');
  //   return List.generate(maps.length, (i) {
  //     // final currentTimeString =
  //     //     maps[i][AddstudentColumns.currenttime].toString();
  //     // final timeParts = currentTimeString.split(':');
  //     // final currentTime = TimeOfDay(
  //     //   hour: int.parse(timeParts[0]),
  //     //   minute: int.parse(timeParts[1]),
  //     // );
  //     return Addstudent(
  //       id: maps[i][AddstudentColumns.id] as int?,
  //       studentname: maps[i][AddstudentColumns.studentname].toString(),
  //       studentmobilenumber: int.parse(
  //           maps[i][AddstudentColumns.studentmobilenumber].toString()),
  //       fathername: maps[i][AddstudentColumns.fathername].toString(),
  //       fathermobilenumber:
  //           int.parse(maps[i][AddstudentColumns.fathermobilenumber].toString()),
  //       mothername: maps[i][AddstudentColumns.mothername].toString(),
  //       mothermobilenumber:
  //           int.parse(maps[i][AddstudentColumns.mothermobilenumber].toString()),

  //       currenttime: maps[i][AddstudentColumns.currenttime].toString(),

  //       // currenttime: '${currentTime.hour}:${currentTime.minute}',
  //       fees: double.parse(maps[i][AddstudentColumns.fees].toString()),
  //       dateOfBirth: maps[i][AddstudentColumns.dateOfBirth].toString(),
  //       batchname: maps[i][AddstudentColumns.batchname].toString(),
  //     );
  //   });
  // }

  static Future<List<Coach>> fetchCoaches(Database db) async {
    final List<Map<String, dynamic>> maps =
        await db.query(AddCoachColumns.tableName);
    return List.generate(maps.length, (i) {
      return Coach(
        id: maps[i][AddCoachColumns.id] as int?,
        name: maps[i][AddCoachColumns.name] as String,
        mobile: maps[i][AddCoachColumns.mobile] as String,
        salary: maps[i][AddCoachColumns.salary] as String,
        bankDetails: maps[i][AddCoachColumns.bankDetails] as String,
        dateOfJoining: maps[i][AddCoachColumns.dateOfJoining] as String,
        dateOfResignation: maps[i][AddCoachColumns.dateOfResignation] as String,
        idCardPath: maps[i][AddCoachColumns.idCardPath] as String,
        bankPassbookPath: maps[i][AddCoachColumns.bankPassbookPath] as String,
      );
    });
  }

  static Future<void> insertCoach(Database db, Coach newCoach) async {
    await db.insert(
      AddCoachColumns.tableName, // Ensure this is the correct table name
      newCoach.toMap(), // Convert Coach object to a Map
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateCoach(Database db, Coach updatedCoach) async {
    await db.update(
      AddCoachColumns.tableName, // Ensure this is the correct table name
      updatedCoach.toMap(), // Convert updated coach object to a Map
      where: '${AddCoachColumns.id} = ?',
      whereArgs: [updatedCoach.id],
    );
  }

  static Future<void> deleteCoach(Database db, int coachId) async {
    await db.delete(
      AddCoachColumns.tableName, // Ensure this is the correct table name
      where: '${AddCoachColumns.id} = ?',
      whereArgs: [coachId],
    );
  }

  static Future<void> updateStudent(
      Database db, Addstudent updatedStudent) async {
    await db.update(
      addstudentName, // Ensure this is the correct table name
      updatedStudent.toMap(), // Convert updated student object to a Map
      where: 'id = ?',
      whereArgs: [updatedStudent.id],
    );
    final List<Map<String, dynamic>> maps =
        await db.rawQuery(''' select * from AddstudentName''');
    log("Std List${maps.toString()}");
  }

  static Future changeActToInAct(Database db, int id) async {
    List<Map<String, Object?>> result = await db.rawQuery(
        ''' UPDATE $addstudentName  SET isActive = "InActive" Where id= $id ''');
    //log("Updated Coupon list::" + result.toString());
    return result;
  }

//
// BatchTableName
  static Future<void> deleteBatch(Database db, int batchId) async {
    await db.delete(
      batchtablename, // replace with your table name
      where: 'id = ?',
      whereArgs: [batchId],
    );
  }

  static Future<void> deleteStudent(Database db, int studentId) async {
    await db.delete(
      addstudentName, // replace with your table name
      where: 'id = ?',
      whereArgs: [studentId],
    );
  }

  static Future<int> insertInactiveStudent(
      Database db, Addstudent student) async {
    return await db.insert('inactive_students', student.toMap());
  }

  static Future<int> deleteActiveStudent(Database db, int id) async {
    return await db.delete('AddstudentName', where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Addstudent>> fetchActiveStudents(
    Database db,
  ) async {
    final List<Map<String, dynamic>> maps =
        await db.rawQuery(''' select * from AddstudentName''');
    log("Std List111::$maps");
    return List.generate(maps.length, (i) {
      return Addstudent.fromMap(maps[i]);
    });
  }
  // static Future<List<Addstudent>> fetchActiveStudents(Database db) async {
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     'AddstudentName',
  //     where: '${AddstudentColumns.isActive} = ?',
  //     whereArgs: [1],
  //   );
  //   log("Std List" + maps.toString());
  // return List.generate(maps.length, (i) {
  //   return Addstudent.fromMap(maps[i]);
  // });
  // }

  static Future<List<Addstudent>> fetchInactiveStudents(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query('inactive_students');
    return List.generate(maps.length, (i) {
      return Addstudent.fromMap(maps[i]);
    });
  }
}
