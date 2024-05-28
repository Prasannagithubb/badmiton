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
  // Create an empty list
  List<TextEditingController> mycontroller =
      List.generate(10, (i) => TextEditingController());
  // Create a controller and get the value for textformfield
  List<TextEditingController> batchstudentctrlr =
      List.generate(10, (i) => TextEditingController());
  List<Batchs> get getbatches => batches;
  final batchstudentformKey = GlobalKey<FormState>();
  final batchformKey = GlobalKey<FormState>();
  String selectedTiming = '4pm to 5pm';

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
    fetchBatches();
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

  Future<void> batchaddstudentlist( 
  
  context) async {
    final Database? db = await DBHelper.getInstance();
    if (batchstudentformKey.currentState!.validate()) {
      DateTime dob = DateTime.parse(batchstudentctrlr[7].text);
      Addstudent batchaddstudents2 = Addstudent(
        studentname:
        
         batchstudentctrlr[0].text,
        studentmobilenumber: int.parse(batchstudentctrlr[1].text),
        fathername: batchstudentctrlr[2].text,
        fathermobilenumber: int.parse(batchstudentctrlr[3].text),
        mothername: batchstudentctrlr[4].text,
        mothermobilenumber: int.parse(batchstudentctrlr[5].text),
        fees: int.parse(batchstudentctrlr[6].text),
        dateOfBirth: dob.toString(),
        batchname: selectedBatch.toString(),
      );

      await DBOperation.insertStudentTable(db!, batchaddstudents2);
      // context.read<AddStudentProvider>().addstudents = batchaddstudents;

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
    notifyListeners();
  }

  Future<void> fetchBatches() async {
    final Database db = (await DBHelper.getInstance())!;
    batches = await DBOperation.fetchBatches(db);
    notifyListeners();
  }

  Future<void> deleteBatch(int index) async {
    final Database? db = await DBHelper.getInstance();
    if (db != null) {
      final batchToDelete = batches[index];
      if (batchToDelete.id != null) {
        await DBOperation.deleteBatch(db, batchToDelete.id!);
        await fetchBatches();
      } else {
        // Handle the case where the batch ID is null, if necessary
        print("Batch ID is null, cannot delete.");
      }
    }
  }

  Future<List<Addstudent>> fetchStudentsByBatchId(int batchId) async {
    // Get the database instance
    final db = await DBHelper.getInstance();

    // Check if the database instance is not null
    if (db != null) {
      // Query the database for students with the given batchId
      final List<Map<String, dynamic>> studentMaps = await db.query(
        'AddstudentName', // Table name for students
        where: '${AddstudentColumns.batchname} = ?',
        whereArgs: [batchId],
      );

      // Convert the query results into Addstudent objects
      return List.generate(studentMaps.length, (index) {
        return Addstudent(
          id: studentMaps[index][AddstudentColumns.id],
          batchname: studentMaps[index][AddstudentColumns.batchname],
          studentname: studentMaps[index][AddstudentColumns.studentname],
          studentmobilenumber: studentMaps[index]
              [AddstudentColumns.studentmobilenumber],
          fathername: studentMaps[index][AddstudentColumns.fathername],
          fathermobilenumber: studentMaps[index]
              [AddstudentColumns.fathermobilenumber],
          mothername: studentMaps[index][AddstudentColumns.mothername],
          mothermobilenumber: studentMaps[index]
              [AddstudentColumns.mothermobilenumber],
          fees: studentMaps[index][AddstudentColumns.fees],
          currenttime: studentMaps[index][AddstudentColumns.currenttime],
          dateOfBirth: studentMaps[index][AddstudentColumns.dateOfBirth],
          isActive: studentMaps[index][AddstudentColumns.isActive] == 1,
        );
      });
    } else {
      // Return an empty list if the database instance is null
      return [];
    }
  }

  void addBatchList( context) async {
    final Database? db = await DBHelper.getInstance();

    if (db != null && batchformKey.currentState!.validate()) {
      try {
        Batchs newBatch = Batchs(
          name: mycontroller[0].text,
          description: mycontroller[1].text,
          fees: double.tryParse(mycontroller[2].text) ?? 0.0,
          batchDays: checkboxValues,
          studentIntake: int.tryParse(mycontroller[3].text) ?? 0,
          time:
              '${currenttime.hour}:${currenttime.minute}:${currenttime.second}',
          isActive: false,
        );

        // Insert the new batch into the database
        await DBOperation.insertBatchTable(db, newBatch);
        notifyListeners();

        // Fetch the updated list of batches
        await fetchBatches();
        notifyListeners();

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Batch added successfully!'),
          ),
        );

        // Navigate back to the previous page
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
