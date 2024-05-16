import 'package:flutter/material.dart';

class Addstudent {
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
}
