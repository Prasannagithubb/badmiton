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
  // TextEditingController batchController = TextEditingController();
  List<String> selectedWeekdays = []; // List to store selected weekdays
  List<String> selectedWeekends = [];
  bool isChecked = false;
  List<bool> checkboxValues = List.generate(8, (index) => false);

  init(BuildContext context) {
    clearAll();
    fetchStudents(context);
    batchList();
  }

  clearAll() {
    addstudents = [];
    isActAddstudents = [];
    inActAddstudents = [];
    batchItem = [];
    studentcondition = false;
    studentcontroller = List.generate(10, (i) => TextEditingController());
  }

  // void addStudent(Addstudent addstudent) {
  //   addstudents.add(addstudent);
  //   notifyListeners();
  // }

  Future<void> toggleStudentActive( context, int id) async {
    final Database? db = await DBHelper.getInstance();
    await DBOperation.changeActToInAct(db!, id);
    await fetchStudents(context);
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
  Future<void> toggleStudentCondition(BuildContext context) async {
    if (studentcondition == true) {
      log('Adding student');
      await addStudentList(context);
    } else {
      log('Updating student');
      updatedstudent(context);
    }
    notifyListeners();
  }

  Future<void> deleteStudent( context, int id) async {
    final Database? db = await DBHelper.getInstance();
    if (db != null) {
      // final studentToDelete = addstudents[index];
      // if (studentToDelete.id != null) {
      // Move student to inactive table
      // await DBOperation.insertInactiveStudent(db, studentToDelete);
      // Delete student from active table
      await DBOperation.deleteActiveStudent(db, id);
      await fetchStudents(context);
      notifyListeners();
      // } else {
      //   log("Student ID is null, cannot delete.");
      // }
    }
  }

  List<String> batchItem = [];
  Future<void> fetchStudents(BuildContext context) async {
    isActAddstudents = [];
    inActAddstudents = [];
    addstudents = [];

    final Database db = (await DBHelper.getInstance())!;

    addstudents = await DBOperation.fetchActiveStudents(db);
    log('addstudents length::${addstudents.length}');
    for (var i = 0; i < addstudents.length; i++) {
      if (addstudents[i].isActive == "Active") {
        log('addstudents111 length::${addstudents.length}');

        isActAddstudents.add(Addstudent(
            id: addstudents[i].id,
            batchname: addstudents[i].batchname,
            isActive: addstudents[i].isActive,
            dateOfBirth: addstudents[i].dateOfBirth,
            studentname: addstudents[i].studentname,
            studentmobilenumber: addstudents[i].studentmobilenumber,
            fathername: addstudents[i].fathername,
            fathermobilenumber: addstudents[i].fathermobilenumber,
            mothername: addstudents[i].mothername,
            mothermobilenumber: addstudents[i].mothermobilenumber,
            fees: addstudents[i].fees));

        // notifyListeners();
      } else {
        log('addstudents222 length::${addstudents.length}');

        inActAddstudents.add(Addstudent(
            id: addstudents[i].id,
            isActive: addstudents[i].isActive,
            batchname: addstudents[i].batchname,
            dateOfBirth: addstudents[i].dateOfBirth,
            studentname: addstudents[i].studentname,
            studentmobilenumber: addstudents[i].studentmobilenumber,
            fathername: addstudents[i].fathername,
            fathermobilenumber: addstudents[i].fathermobilenumber,
            mothername: addstudents[i].mothername,
            mothermobilenumber: addstudents[i].mothermobilenumber,
            fees: addstudents[i].fees));
        notifyListeners();
      }
      // inActAddstudents = await DBOperation.fetchInactiveStudents(db);
      notifyListeners();
    }
    log('isActAddstudents length::${isActAddstudents.length}');
  }

  Future<void> updatedstudent( context) async {
    int i = indexstudent!;
    final Database? db = await DBHelper.getInstance();

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

      Addstudent updatestn = Addstudent(
          id: addstudents[i].id,
          batchname: addstudents[i].batchname,
          dateOfBirth: addstudents[i].dateOfBirth,
          studentname: addstudents[i].studentname,
          studentmobilenumber: addstudents[i].studentmobilenumber,
          fathername: addstudents[i].fathername,
          fathermobilenumber: addstudents[i].fathermobilenumber,
          mothername: addstudents[i].mothername,
          mothermobilenumber: addstudents[i].mothermobilenumber,
          isActive: addstudents[i].isActive,
          currenttime: addstudents[i].currenttime,
          fees: addstudents[i].fees);

      DBOperation.updateStudent(db!, updatestn);
      fetchStudents(context);
      Navigator.pop(context);
      notifyListeners();
      // addstudents[i] = addstdn;
    } catch (e) {
      log('Error parsing values: $e');
    }
  }

  // void actToInActstudent(BuildContext context) {
  //   int i = indexstudent!;
  //   try {
  //     addstudents[i].studentname = studentcontroller[0].text;
  //     addstudents[i].studentmobilenumber = int.parse(studentcontroller[1].text);
  //     addstudents[i].fathername = studentcontroller[2].text;
  //     addstudents[i].fathermobilenumber = int.parse(studentcontroller[3].text);
  //     addstudents[i].mothername = studentcontroller[4].text;
  //     addstudents[i].mothermobilenumber = int.parse(studentcontroller[5].text);
  //     addstudents[i].currenttime =
  //         '${studentcurrentTime.hour}:${studentcurrentTime.minute}';
  //     // addstudents[i].currenttime = studentcurrentTime;
  //     addstudents[i].fees = double.parse(studentcontroller[6].text);
  //     addstudents[i].dateOfBirth = studentcontroller[7].text;
  //     addstudents[i].batchname = selectedBatch.toString();
  //     addstudents[i].isActive = "InActive";
  //     Navigator.pop(context);
  //     notifyListeners();
  //     // addstudents[i] = addstdn;
  //   } catch (e) {
  //     print('Error parsing values: $e');
  //   }
  // }

  // DateTime? dob;
  batchList() async {
    batchItem = [];
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> batchitemList =
        await DBOperation.getBatchList(db);
    for (var i = 0; i < batchitemList.length; i++) {
      batchItem.add(batchitemList[i]['batchname'].toString());
    }
    log('batchItembatchItem::${batchItem.length}');
  }

  editstudent(Addstudent addstdn, int i) {
    log("addstdn.batchname:::${addstdn.batchname}");
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
    selectedBatch = addstdn.batchname;
    notifyListeners();
  }

  addStudentList(context) async {
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
            currenttime:'${studentcurrentTime.hour}:${studentcurrentTime.minute}',
            fees: double.parse(studentcontroller[6].text),
            dateOfBirth: studentcontroller[7].text,
            batchname: selectedBatch.toString(),
            isActive: "Active");

        // Insert the new student into the database
        await DBOperation.insertStudentTable(db, newStudent);
        // Fetch the updated list of students
        await fetchStudents(
            context); // Ensure this is called to refresh the list
        notifyListeners();
        if (addstudents.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Student added successfully!'),
            ),
          );
          notifyListeners();
        }
        // Show a success message

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
