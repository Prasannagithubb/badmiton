// import 'package:flutter/material.dart';

class Batch {
  final String name;
  final String description;
  final double fees;
  final List<bool> batchDays;
  final int studentIntake;
  final String time;
    bool isActive;

  Batch({
    required this.name,
    required this.description,
    required this.fees,
    required this.batchDays,
    required this.studentIntake,
    required this.time,
    required this.isActive
  });
}
