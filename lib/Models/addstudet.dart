import 'package:badmiton_app/dbmodel/addstudentmodel.dart';
import 'package:flutter/material.dart';

class Addstudent {
  int? id;
  String batchname;
  String studentname;
  int studentmobilenumber;
  String fathername;
  int fathermobilenumber;
  String mothername;
  int mothermobilenumber;
  int fees;
  TimeOfDay? currenttime;
  DateTime dateOfBirth;
  bool isActive; // Moved to the beginning of the constructor

  Addstudent({
    this.id,
    required this.batchname,
    required this.dateOfBirth,
    required this.studentname,
    required this.studentmobilenumber,
    required this.fathername,
    required this.fathermobilenumber,
    required this.mothername,
    required this.mothermobilenumber,
    this.currenttime,
    required this.fees,
    this.isActive = true,
  });
  Map<String, Object?> toMap() => {
        AddstudentColumns.batchname: batchname,
        AddstudentColumns.dateOfBirth: dateOfBirth,
        AddstudentColumns.studentname: studentname,
        AddstudentColumns.studentmobilenumber: studentmobilenumber,
        AddstudentColumns.fathername: fathername,
        AddstudentColumns.fathermobilenumber: fathermobilenumber,
        AddstudentColumns.mothername: mothername,
        AddstudentColumns.mothermobilenumber: mothermobilenumber,
        AddstudentColumns.currenttime: currenttime,
        AddstudentColumns.fees: fees,
        AddstudentColumns.isActive: isActive,
      };
}
