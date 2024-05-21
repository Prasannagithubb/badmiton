
import 'package:flutter/material.dart';

const String addstudentName = "AddstudentName";

class AddstudentColumns {
  
  static const String batchname = "batchname";
  static const String studentname = "studentname";
  static const String studentmobilenumber = "studentmobilenumber";
  static const String fathername = "fathername";
  static const String fathermobilenumber = "fathermobilenumber";
  static const String mothername = "mothername";
  static const String mothermobilenumber = "mothermobilenumber";
  static const String fees = "fees";
  static const String currenttime = "currenttime";
  static const String dateOfBirth = "dateOfBirth";
  static const String isActive = "isActive";
}


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
  String? currenttime;
  String dateOfBirth;
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