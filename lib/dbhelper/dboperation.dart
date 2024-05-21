import 'dart:developer';

import 'package:badmiton_app/dbmodel/addstudentmodel.dart';
import 'package:badmiton_app/dbmodel/batchmodel.dart';
import 'package:flutter/material.dart';
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
        // id: maps[i][AddBatchColumns.id] as int?,
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

  static Future<List<Addstudent>> fetchStudents(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query(addstudentName);
    log('results:::${maps.toList()}');
    return List.generate(maps.length, (i) {
      final currentTimeString =
          maps[i][AddstudentColumns.currenttime].toString();
      final timeParts = currentTimeString.split(':');
      final currentTime = TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      );

      return Addstudent(
        studentname: maps[i][AddstudentColumns.studentname].toString(),
        studentmobilenumber: int.parse(
            maps[i][AddstudentColumns.studentmobilenumber].toString()),
        fathername: maps[i][AddstudentColumns.fathername].toString(),
        fathermobilenumber:
            int.parse(maps[i][AddstudentColumns.fathermobilenumber].toString()),
        mothername: maps[i][AddstudentColumns.mothername].toString(),
        mothermobilenumber:
            int.parse(maps[i][AddstudentColumns.mothermobilenumber].toString()),
        currenttime: '${currentTime.hour}:${currentTime.minute}',
        fees: int.parse(maps[i][AddstudentColumns.fees].toString()),
        dateOfBirth: maps[i][AddstudentColumns.dateOfBirth].toString(),
        batchname: maps[i][AddstudentColumns.batchname].toString(),
      );
    });
  }

    static Future<void> deleteBatch(Database db, String batchName) async {
    await db.delete(
      'batchtablename', // replace with your table name
      where: 'name = ?',
      whereArgs: [batchName],
    );
  }
}
