import 'dart:developer';
import 'package:badmiton_app/Models/addstudet.dart';
import 'package:flutter/material.dart';
import '../dashboardcontroller.dart/dash_board_provider.dart';

class AddStudentProvider with ChangeNotifier {
  List<TextEditingController> studentcontroller =
      List.generate(10, (index) => TextEditingController());

  final GlobalKey<FormState> addstuentkey1 = GlobalKey<FormState>();
  List<Addstudent> addstudents = [];
  TimeOfDay studentcurrentTime = TimeOfDay.now();
  String? selectedBatch;
  int? indexstudent;

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
    if (studentcondition == true) {
      log('kkkkkkkkkkkkk');
      addstudentlist(context);
      notifyListeners();
    } else {
      log('mmmmmmmmmmmmmmmmm');

      updatedstudent(context);
      notifyListeners();
    }
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
      addstudents[i].currenttime = studentcurrentTime;
      addstudents[i].fees = int.parse(studentcontroller[6].text);
      addstudents[i].dateOfBirth = DateTime.parse(studentcontroller[7].text);
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

  addstudentlist(BuildContext context) {
    if (addstuentkey1.currentState!.validate()) {
      addstudents.add(Addstudent(
        studentname: studentcontroller[0].text,
        studentmobilenumber: int.parse(studentcontroller[1].text),
        fathername: studentcontroller[2].text,
        fathermobilenumber: int.parse(studentcontroller[3].text),
        mothername: studentcontroller[4].text,
        mothermobilenumber: int.parse(studentcontroller[5].text),
        currenttime: studentcurrentTime,
        fees: int.parse(studentcontroller[6].text),
        dateOfBirth: DateTime.parse(studentcontroller[7].text),
        batchname: selectedBatch.toString(),
      ));
      notifyListeners();
      Navigator.pop(context);
      // DashboardProvider.selectedIndex = 2;
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => DashBoard()));
      log('SSSSSSSSSSSSSS::${DashboardProvider.selectedIndex}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student added!'),
        ),
      );
      notifyListeners();
    }
    // Get.to(() => const DashStuddent());
    notifyListeners();
  }
}
