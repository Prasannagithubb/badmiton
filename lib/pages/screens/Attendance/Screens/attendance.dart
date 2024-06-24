import 'package:badmiton_app/controller/dashstudentcontroller.dart/add_student_provider.dart';
import 'package:badmiton_app/dbmodel/addstudentmodel.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
// import 'package:easy_date_timeline/easy_date_timeline.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<Addstudent> students = [];
  DateTime selectedDate = DateTime.now();
  bool isAttendanceLocked = false;

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  void fetchStudents() async {
    final addStudentProvider =
        Provider.of<AddStudentProvider>(context, listen: false);
    await addStudentProvider.fetchStudents(context);
    setState(() {
      students = addStudentProvider.addstudents;
    });
  }

  void handleDateChange(DateTime newDate) {
    setState(() {
      selectedDate = newDate;

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      if (newDate.isBefore(today)) {
        print('Selected date is in the past. Attendance is locked.');
        isAttendanceLocked = true;
      } else {
        print(
            'Selected date is today or in the future. Attendance is unlocked.');
        isAttendanceLocked = false;
      }

      print('Selected date: $selectedDate');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Attendance'),
        ),
        body: Column(
          children: [
          EasyInfiniteDateTimeLine(
            selectionMode: const SelectionMode.autoCenter(),
            firstDate: DateTime(2000), // Set to January 1, 2010
            focusDate: selectedDate, // Set focus date to today
            lastDate: DateTime.now(),
            onDateChange: (selectedDate) {
              handleDateChange(selectedDate);
            },
            dayProps: const EasyDayProps(
              width: 64.0,
              height: 80.0,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.green,
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              'List of students',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(
                      student.studentname,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      student.isPresent! ? 'Present' : 'Absent',
                      style: TextStyle(
                        color: student.isPresent! ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: isAttendanceLocked
                        ? null // Disable the switch if attendance is locked
                        : Switch(
                            value: student.isPresent!,
                            onChanged: (bool value) {
                              setState(() {
                                student.isPresent = value;
                              });
                            },
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[300],
                          ),
                  ),
                );
              },
            ),
          ),
        ]));
  }
}
