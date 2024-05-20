// batch_list_provider.dart
import 'dart:developer';

import 'package:badmiton_app/constant/ConstantRoutes.dart';
import 'package:badmiton_app/controller/dashboardcontroller.dart/dash_board_provider.dart';
import 'package:badmiton_app/dbhelper/dbhelper.dart';
import 'package:badmiton_app/dbhelper/dboperation.dart';
import 'package:badmiton_app/dbmodel/batchmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../Models/addstudet.dart';
import '../dashstudentcontroller.dart/add_student_provider.dart';

class BatchListProvider extends ChangeNotifier {
  List<Batchs> batches = [];
  //crete a empty list
  List<TextEditingController> mycontroller =
      List.generate(10, (i) => TextEditingController());
  // create a controller and get the value for texformfield
  List<TextEditingController> batchstudentctrlr =
      List.generate(10, (i) => TextEditingController());
  List<Batchs> get getbatches => batches;
  final batchstudentformKey = GlobalKey<FormState>();
  final batchformKey = GlobalKey<FormState>();

  List<bool> checkboxValues = List.generate(7, (index) => false);
  DateTime currenttime = DateTime.now();
  FocusNode nameFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  FocusNode feesFocusNode = FocusNode();
  final pageController = PageController(initialPage: 0);
  final studentcurrentTime = TimeOfDay.now();

  FocusNode studentIntakeFocusNode = FocusNode();
  void addBatch(Batchs batch) {
    batches.add(batch);
    notifyListeners();
  }

  init() {
    clearAll();
    batchCount();
    notifyListeners();
  }

  clearAll() {
    checkboxValues = List.generate(7, (index) => false);
    mycontroller = List.generate(50, (i) => TextEditingController());
    batchstudentctrlr = List.generate(50, (i) => TextEditingController());
    notifyListeners();
  }

  clearAdd() {
    checkboxValues = List.generate(7, (index) => false);
    batchstudentctrlr = List.generate(50, (i) => TextEditingController());
    notifyListeners();
  }

  batchCount() {
    if (mycontroller[3].text.isEmpty) {
      mycontroller[3].text = '20';
      notifyListeners();
    }
  }

  String getSelectedDays(List<bool> batchDays) {
    List<String> dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    List<String> selectedDays = [];

    for (int i = 0; i < batchDays.length; i++) {
      if (batchDays[i]) {
        selectedDays.add(dayNames[i]);
      }
    }

    return selectedDays.join(' ');
  }

  // Add this inside your BatchListProvider
  int get activeCount {
    return batches.where((batch) => batch.isActive).length;
  }

  String? selectedBatch;
  List<Addstudent> batchaddstudents = [];
  batchaddstudentlist(BuildContext context) async {
    final db = await DBHelper.getInstance();
    if (batchstudentformKey.currentState!.validate()) {
      DateTime dob = DateTime.parse(batchstudentctrlr[7].text);
      batchaddstudents.add(Addstudent(
        studentname: batchstudentctrlr[0].text,
        studentmobilenumber: int.parse(batchstudentctrlr[1].text),
        fathername: batchstudentctrlr[2].text,
        fathermobilenumber: int.parse(batchstudentctrlr[3].text),
        mothername: batchstudentctrlr[4].text,
        mothermobilenumber: int.parse(batchstudentctrlr[5].text),
        fees: int.parse(batchstudentctrlr[6].text),
        dateOfBirth: dob,
        batchname: selectedBatch.toString(),
      ));

      context.read<AddStudentProvider>().addstudents = batchaddstudents;

      notifyListeners();
      DashboardProvider.selectedIndex = 2;
      Get.offAllNamed(ConstantRoutes.dashboard);

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

  addBatchList(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;

    if (batchformKey.currentState!.validate()) {
      batches.add(
        Batchs(
          name: mycontroller[0].text,
          description: mycontroller[1].text,
          fees: double.parse(mycontroller[2].text),
          batchDays: checkboxValues,
          studentIntake: int.parse(mycontroller[3].text),
          time:
              '${currenttime.hour}:${currenttime.minute}:${currenttime.second}',
          isActive: false,
        ),
      );
      await DBOperation.insertBatchTable(
        db,
        batches,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Batch added successfully!'),
        ),
      );
      notifyListeners();
    }
    // Navigate back to the previous page
    Get.back();
    notifyListeners();
  }

  void removeBatch(Batchs batch) {
    batches.remove(batch);
    notifyListeners();
  }

  void deleteBatch(int i) {
    batches.removeAt(i);
    notifyListeners();
  }

  // void selectTime(BuildContext context) async {
  //   final DateTime? selectedTime = await showTimePicker(
  //     context: context,
  //     initialTime: currenttime.toString(),
  //   );

  //   if (selectedTime != null) {
  //     currenttime = selectedTime;
  //   }
  // }

  void selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now() // Use TimeOfDay object here
        );

    if (selectedTime != null) {
      currenttime = DateTime.parse(selectedTime.toString());
    }
  }
}
