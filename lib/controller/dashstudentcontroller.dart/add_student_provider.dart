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
  TimeOfDay studentcurrentTime = TimeOfDay.now();
  String? selectedBatch;
  int? indexstudent;
  TextEditingController batchController = TextEditingController();
  List<String> selectedWeekdays = []; // List to store selected weekdays
  List<String> selectedWeekends = [];
  bool isChecked = false;
  List<bool> checkboxValues = List.generate(8, (index) => false);

  clearAll() {
    studentcondition = false;
    studentcontroller = List.generate(10, (i) => TextEditingController());
    notifyListeners();
  }

  // void addStudent(Addstudent addstudent) {
  //   addstudents.add(addstudent);
  //   notifyListeners();
  // }

  void toggleStudentActive(int index) {
    var student = addstudents[index];
    student.isActive = !student.isActive;
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

  Future<void> deleteStudent(int index) async {
    final Database? db = await DBHelper.getInstance();
    if (db != null) {
      final batchToDelete = addstudents[index];
      if (batchToDelete.id != null) {
        await DBOperation.deleteStudent(db, batchToDelete.id!);
        await fetchStudents();
      } else {
        // Handle the case where the batch ID is null, if necessary
        log("Batch ID is null, cannot delete.");
      }
    }
  }

  Future<void> fetchStudents() async {
    addstudents = [];
    final Database db = (await DBHelper.getInstance())!;
    addstudents = await DBOperation.fetchStudents(db);
    notifyListeners();
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
      addstudents[i].currenttime ='${studentcurrentTime.hour}:${studentcurrentTime.minute}';
      // addstudents[i].currenttime = studentcurrentTime;
      addstudents[i].fees = int.parse(studentcontroller[6].text);
      addstudents[i].dateOfBirth = studentcontroller[7].text;
      addstudents[i].batchname = selectedBatch.toString();
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
          currenttime:
              '${studentcurrentTime.hour}:${studentcurrentTime.minute}',
          fees: int.tryParse(studentcontroller[6].text) ?? 0,
          dateOfBirth: studentcontroller[7].text,
          batchname: selectedBatch.toString(),
        );

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
