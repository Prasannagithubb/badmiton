import 'dart:developer';
import 'package:badmiton_app/constant/ConstantRoutes.dart';
import 'package:badmiton_app/controller/dashboardcontroller.dart/dash_board_provider.dart';
import 'package:badmiton_app/dbhelper/dbhelper.dart';
import 'package:badmiton_app/dbhelper/dboperation.dart';
import 'package:badmiton_app/dbmodel/addstudentmodel.dart';
import 'package:badmiton_app/dbmodel/batchmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class BatchListProvider extends ChangeNotifier {
  List<Batchs> batches = [];
  List<TextEditingController> mycontroller =
      List.generate(10, (i) => TextEditingController());
  List<TextEditingController> batchstudentctrlr =
      List.generate(10, (i) => TextEditingController());
  List<Batchs> get getbatches => batches;
  final batchstudentformKey = GlobalKey<FormState>();
  final batchformKey = GlobalKey<FormState>();
  String selectedTiming = '4pm to 5pm';
  List<bool> checkboxValues = List.generate(7, (index) => false);
  DateTime currenttime = DateTime.now();
  // FocusNode descriptionFocusNode = FocusNode();
  // FocusNode feesFocusNode = FocusNode();
  final pageController = PageController(initialPage: 0);
  final studentcurrentTime = TimeOfDay.now();
  String? selectedBatch;
  List<Addstudent> batchaddstudents = [];
  List<Batchs> filteredBatches = [];

  void updateFilteredBatches(String query) {
    if (query.isEmpty) {
      filteredBatches = batches;
    } else {
      filteredBatches = batches
          .where((batch) =>
              batch.name.toLowerCase().contains(query.toLowerCase()) ||
              batch.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  init() {
    clearAll();
    fetchBatchess();
  }

  clearAll() {
    checkboxValues = List.generate(7, (index) => false);
    mycontroller = List.generate(50, (i) => TextEditingController());
    batchstudentctrlr = List.generate(50, (i) => TextEditingController());
  }

  clearAdd() {
    checkboxValues = List.generate(7, (index) => false);
    batchstudentctrlr = List.generate(50, (i) => TextEditingController());
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

  int get activeCount {
    return batches.where((batch) => batch.isActive).length;
  }

  Future<void> batchaddstudentlist(context) async {
    final Database? db = await DBHelper.getInstance();
    if (batchstudentformKey.currentState!.validate()) {
      DateTime dob = DateTime.parse(batchstudentctrlr[7].text);
      Addstudent batchaddstudents2 = Addstudent(
          studentname: batchstudentctrlr[0].text,
          studentmobilenumber: int.parse(batchstudentctrlr[1].text),
          fathername: batchstudentctrlr[2].text,
          fathermobilenumber: int.parse(batchstudentctrlr[3].text),
          mothername: batchstudentctrlr[4].text,
          mothermobilenumber: int.parse(batchstudentctrlr[5].text),
          fees: double.parse(batchstudentctrlr[6].text),
          dateOfBirth: dob.toString(),
          batchname: selectedBatch.toString(),
          isActive: "Active");

      await DBOperation.insertStudentTable(db!, batchaddstudents2);
      notifyListeners();
      DashboardProvider.selectedIndex = 2;
      Get.offAllNamed(ConstantRoutes.dashboard);
      log('SSSSSSSSSSSSSS::${DashboardProvider.selectedIndex}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Student added!'),
        ),
      );
    }
  }

  Future<void> fetchBatchess() async {
    final Database db = (await DBHelper.getInstance())!;
    batches = await DBOperation.fetchBatches(db);
    filteredBatches = batches;
    log('Batch length::::${batches.length}');
    notifyListeners();
  }

  Future<void> deleteBatch(int index) async {
    final Database? db = await DBHelper.getInstance();
    final batchToDelete = batches[index];
    if (batchToDelete.id != null) {
      List<Addstudent> studentsToDelete =
          await fetchStudentsByBatchId(batchToDelete.id!);

      for (Addstudent student in studentsToDelete) {
        await DBOperation.deleteStudent(db!, student.id!);
      }
      await DBOperation.deleteBatch(db!, batchToDelete.id!);
      await fetchBatchess();
    }
  }

  Future<List<Addstudent>> fetchStudentsByBatchId(int batchId) async {
    final db = await DBHelper.getInstance();
    if (db != null) {
      final List<Map<String, dynamic>> studentMaps = await db.query(
        'AddstudentName',
        where: '${AddstudentColumns.batchname} = ?',
        whereArgs: [batchId],
      );

      return List.generate(studentMaps.length, (index) {
        return Addstudent(
          id: studentMaps[index][AddstudentColumns.id],
          batchname: studentMaps[index][AddstudentColumns.batchname],
          studentname: studentMaps[index][AddstudentColumns.studentname],
          studentmobilenumber: studentMaps[index] [AddstudentColumns.studentmobilenumber],
          fathername: studentMaps[index][AddstudentColumns.fathername],
          fathermobilenumber: studentMaps[index] [AddstudentColumns.fathermobilenumber],
          mothername: studentMaps[index][AddstudentColumns.mothername],
          mothermobilenumber: studentMaps[index] [AddstudentColumns.mothermobilenumber],
          fees: studentMaps[index][AddstudentColumns.fees],
          currenttime: studentMaps[index][AddstudentColumns.currenttime],
          dateOfBirth: studentMaps[index][AddstudentColumns.dateOfBirth],
          isActive: studentMaps[index][AddstudentColumns.isActive],
        );
      });
    } else {
      return [];
    }
  }

  Future<void> addBatchList(context) async {
    final Database? db = await DBHelper.getInstance();

    if (db != null && batchformKey.currentState!.validate()) {
      try {
        Batchs newBatch = Batchs(
          name: mycontroller[0].text,
          description: mycontroller[1].text,
          fees: double.tryParse(mycontroller[2].text) ?? 0.0,
          batchDays: checkboxValues,
          studentIntake: int.tryParse(mycontroller[3].text) ?? 0,
          time:'${currenttime.hour}:${currenttime.minute}:${currenttime.second}',
          isActive: false,
        );

        await DBOperation.insertBatchTable(db, newBatch);
        await fetchBatchess();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Batch added successfully!'),
          ),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to add batch. Please try again.'),
          ),
        );
        print('Error adding batch: $e');
      }
    }
  }

  void removeBatch(Batchs batch) {
    batches.remove(batch);
    notifyListeners();
  }

  void selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      currenttime = DateTime(
        currenttime.year,
        currenttime.month,
        currenttime.day,
        selectedTime.hour,
        selectedTime.minute,
      );
    }
  }
}
