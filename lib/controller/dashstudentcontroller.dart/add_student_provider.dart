import 'dart:developer';

import 'package:badmiton_app/dbhelper/dbhelper.dart';
import 'package:badmiton_app/dbhelper/dboperation.dart';
import 'package:badmiton_app/dbmodel/addstudentmodel.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class AddStudentProvider with ChangeNotifier {
  List<TextEditingController> studentcontroller =
      List.generate(10, (index) => TextEditingController());
  final GlobalKey<FormState> addstuentkey1 = GlobalKey<FormState>();
  List<Addstudent> addstudents = [];
  List<Addstudent> isActAddstudents = [];
  List<Addstudent> inActAddstudents = [];

  TimeOfDay studentcurrentTime = TimeOfDay.now();
  String? selectedBatch;
  int? indexstudent;
  TextEditingController batchController = TextEditingController();
  List<String> selectedWeekdays = []; // List to store selected weekdays
  List<String> selectedWeekends = [];
  bool isChecked = false;
  List<bool> checkboxValues = List.generate(8, (index) => false);

  clearAll() {
    isActAddstudents = [];
    inActAddstudents = [];
    studentcondition = false;
    studentcontroller = List.generate(10, (i) => TextEditingController());
    notifyListeners();
  }

  // void addStudent(Addstudent addstudent) {
  //   addstudents.add(addstudent);
  //   notifyListeners();
  // }

  Future<void> toggleStudentActive(int id) async {
    final Database? db = await DBHelper.getInstance();

    // var student = addstudents[index];
    await DBOperation.changeActToInAct(db!, id);
    await fetchStudents();

    // student.isActive = !student.isActive;
    notifyListeners();
  }

  void removeStudent(int index) {
    if (index >= 0 && index < addstudents.length) {
      addstudents.removeAt(index);
      notifyListeners();
    }
  }

  Addstudent? addstdn;

  bool studentcondition = false; // Initially set to false for add operation

  // Method to toggle the student condition between add and edit modes
  void toggleStudentCondition(BuildContext context) {
    if (studentcondition) {
      log('Adding student');
      addStudentList(context);
    } else {
      log('Updating student');
      updatedstudent(context);
    }
    notifyListeners();
  }

  Future<void> deleteStudent(int id) async {
    final Database? db = await DBHelper.getInstance();
    if (db != null) {
      // final studentToDelete = addstudents[index];
      // if (studentToDelete.id != null) {
      // Move student to inactive table
      // await DBOperation.insertInactiveStudent(db, studentToDelete);
      // Delete student from active table
      await DBOperation.deleteActiveStudent(db, id);
      // Remove the student from the active list
      // addstudents.removeAt(index);
      // Fetch the updated list of students
      await fetchStudents();
      notifyListeners();
      // } else {
      //   log("Student ID is null, cannot delete.");
      // }
    }
  }

  Future<void> fetchStudents() async {
    isActAddstudents = [];
    inActAddstudents = [];
    addstudents = [];
    final Database db = (await DBHelper.getInstance())!;
    addstudents = await DBOperation.fetchActiveStudents(db);
    for (var i = 0; i < addstudents.length; i++) {
      if (addstudents[i].isActive == "Active") {
        isActAddstudents.add(Addstudent(
            id: addstudents[i].id,
            batchname: addstudents[i].batchname,
            dateOfBirth: addstudents[i].dateOfBirth,
            studentname: addstudents[i].studentname,
            studentmobilenumber: addstudents[i].studentmobilenumber,
            fathername: addstudents[i].fathername,
            fathermobilenumber: addstudents[i].fathermobilenumber,
            mothername: addstudents[i].mothername,
            mothermobilenumber: addstudents[i].mothermobilenumber,
            fees: addstudents[i].fees));
      } else {
        inActAddstudents.add(Addstudent(
            id: addstudents[i].id,
            batchname: addstudents[i].batchname,
            dateOfBirth: addstudents[i].dateOfBirth,
            studentname: addstudents[i].studentname,
            studentmobilenumber: addstudents[i].studentmobilenumber,
            fathername: addstudents[i].fathername,
            fathermobilenumber: addstudents[i].fathermobilenumber,
            mothername: addstudents[i].mothername,
            mothermobilenumber: addstudents[i].mothermobilenumber,
            fees: addstudents[i].fees));
      }
      // inActAddstudents = await DBOperation.fetchInactiveStudents(db);
      notifyListeners();
    }
  }

  void updatedstudent(BuildContext context) {
    int i = indexstudent!;
    try {
      addstudents[i].studentname = studentcontroller[0].text;
      addstudents[i].studentmobilenumber = int.parse(studentcontroller[1].text);
      addstudents[i].fathername = studentcontroller[2].text;
      addstudents[i].fathermobilenumber = int.parse(studentcontroller[3].text);
      addstudents[i].mothername = studentcontroller[4].text;
      addstudents[i].mothermobilenumber = int.parse(studentcontroller[5].text);
      addstudents[i].currenttime =
          '${studentcurrentTime.hour}:${studentcurrentTime.minute}';
      // addstudents[i].currenttime = studentcurrentTime;
      addstudents[i].fees = double.parse(studentcontroller[6].text);
      addstudents[i].dateOfBirth = studentcontroller[7].text;
      addstudents[i].batchname = selectedBatch.toString();
      addstudents[i].isActive = "Active";
      Navigator.pop(context);
      notifyListeners();
      // addstudents[i] = addstdn;
    } catch (e) {
      print('Error parsing values: $e');
    }
  }

  void actToInActstudent(BuildContext context) {
    int i = indexstudent!;
    try {
      addstudents[i].studentname = studentcontroller[0].text;
      addstudents[i].studentmobilenumber = int.parse(studentcontroller[1].text);
      addstudents[i].fathername = studentcontroller[2].text;
      addstudents[i].fathermobilenumber = int.parse(studentcontroller[3].text);
      addstudents[i].mothername = studentcontroller[4].text;
      addstudents[i].mothermobilenumber = int.parse(studentcontroller[5].text);
      addstudents[i].currenttime =
          '${studentcurrentTime.hour}:${studentcurrentTime.minute}';
      // addstudents[i].currenttime = studentcurrentTime;
      addstudents[i].fees = double.parse(studentcontroller[6].text);
      addstudents[i].dateOfBirth = studentcontroller[7].text;
      addstudents[i].batchname = selectedBatch.toString();
      addstudents[i].isActive = "Active";
      Navigator.pop(context);
      // addstudents[i] = addstdn;
    } catch (e) {
      print('Error parsing values: $e');
    }
  }

  DateTime? dob;

  editstudent(Addstudent addstdn, int i) {
    log(studentcondition.toString());
    studentcondition = false;
    indexstudent = i;
    studentcontroller[0].text = addstdn.studentname;
    studentcontroller[1].text = addstdn.studentmobilenumber.toString();
    studentcontroller[2].text = addstdn.fathername;
    studentcontroller[3].text = addstdn.fathermobilenumber.toString();
    studentcontroller[4].text = addstdn.mothername;
    studentcontroller[5].text = addstdn.mothermobilenumber.toString();
    studentcontroller[6].text = addstdn.fees.toString();
    studentcontroller[7].text = addstdn.dateOfBirth.toString();
  }

  void addStudentList(context) async {
    final Database? db = await DBHelper.getInstance();

    if (db != null && addstuentkey1.currentState!.validate()) {
      try {
        Addstudent newStudent = Addstudent(
            studentname: studentcontroller[0].text,
            studentmobilenumber: int.tryParse(studentcontroller[1].text) ?? 0,
            fathername: studentcontroller[2].text,
            fathermobilenumber: int.tryParse(studentcontroller[3].text) ?? 0,
            mothername: studentcontroller[4].text,
            mothermobilenumber: int.tryParse(studentcontroller[5].text) ?? 0,
            currenttime: '${studentcurrentTime.hour}:${studentcurrentTime.minute}',
            fees: double.parse(studentcontroller[6].text),
            dateOfBirth: studentcontroller[7].text,
            batchname: selectedBatch.toString(),
            isActive: "Active");

        // Insert the new student into the database
        await DBOperation.insertStudentTable(db, newStudent);
        // Fetch the updated list of students
        await fetchStudents(); // Ensure this is called to refresh the list
        notifyListeners();

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Student added successfully!'),
          ),
        );

        // Navigate back to the previous page
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add student. Please try again.'),
          ),
        );
        log('Error adding student: $e');
      }
    }
  }
}
