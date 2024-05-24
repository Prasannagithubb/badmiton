import 'dart:developer';

import 'package:badmiton_app/dbhelper/dbhelper.dart';
import 'package:badmiton_app/dbhelper/dboperation.dart';
import 'package:badmiton_app/dbmodel/coachmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';

class DashCoachProvider extends ChangeNotifier {
  int? indexStudent;
  final coachFormKey = GlobalKey<FormState>();
  List<TextEditingController> coachController =
      List.generate(10, (i) => TextEditingController());
  DateTime? dateOfJoining;
  DateTime? dateOfResignation;

  XFile? _idCardImage;
  XFile? _bankPassbookImage;

  bool couchSwitch = false;

  List<Coach> coaches = [];

  void init() {
    clearAll();
    fetchCoaches();
  }

  void clearAll() {
    coachController = List.generate(10, (i) => TextEditingController());
    couchSwitch = false;
    notifyListeners();
  }

  bool validateForm({
    required bool isIdCardSelected,
    required bool isBankPassbookSelected,
  }) {
    final formValid = coachFormKey.currentState?.validate() ?? false;
    return formValid && isIdCardSelected && isBankPassbookSelected;
  }

  void removeCoach(int index) async {
    if (index >= 0 && index < coaches.length) {
      final coachToRemove = coaches[index];
      final Database? db = await DBHelper.getInstance();
      if (db != null && coachToRemove.id != null) {
        await DBOperation.deleteCoach(db, coachToRemove.id!);
        coaches.removeAt(index);
        notifyListeners();
      }
    }
  }

Future<void> updateCoach(BuildContext context, {required String idCardPath, required String bankPassbookPath}) async {
    int i = indexStudent!;
    try {
      final Database? db = await DBHelper.getInstance();
      if (db != null) {
        final coach = coaches[i]
          ..name = coachController[0].text
          ..mobile = coachController[1].text
          ..salary = coachController[2].text
          ..bankDetails = coachController[3].text
          ..dateOfJoining = coachController[4].text
          ..dateOfResignation = coachController[5].text
          ..idCardPath = idCardPath
          ..bankPassbookPath = bankPassbookPath;

        await DBOperation.updateCoach(db, coach);
        Navigator.pop(context);
        fetchCoaches();
      }
    } catch (e) {
      log('Error updating coach: $e');
    }
}


  void editCoach(Coach coach, int i) {
    couchSwitch = false;
    indexStudent = i;

    coachController[0].text = coach.name;
    coachController[1].text = coach.mobile;
    coachController[2].text = coach.salary;
    coachController[3].text = coach.bankDetails;
    coachController[4].text = coach.dateOfJoining;
    coachController[5].text = coach.dateOfResignation;
    _idCardImage = XFile(coach.idCardPath);
    _bankPassbookImage = XFile(coach.bankPassbookPath);

    notifyListeners();
  }

  void saveOrUpdateCoach(
    BuildContext context,
    String idCardPath,
    String bankPassbookPath,
  ) {
    if (couchSwitch) {
      saveForm(idCardPath, bankPassbookPath);
    } else {
      updateCoach(context, idCardPath: '', bankPassbookPath: '');
    }
    notifyListeners();
  }

  void saveForm(String idCardPath, String bankPassbookPath) async {
    if (validateForm(
        isIdCardSelected: idCardPath.isNotEmpty,
        isBankPassbookSelected: bankPassbookPath.isNotEmpty)) {
      final Database? db = await DBHelper.getInstance();
      if (db != null) {
        final coach = Coach(
          name: coachController[0].text,
          mobile: coachController[1].text,
          salary: coachController[2].text,
          bankDetails: coachController[3].text,
          dateOfJoining: coachController[4].text,
          dateOfResignation: coachController[5].text,
          idCardPath: idCardPath,
          bankPassbookPath: bankPassbookPath,
        );
        await DBOperation.insertCoach(db, coach);
        coaches.add(coach);
        notifyListeners();
      }
    }
  }

  Future<void> fetchCoaches() async {
    final Database? db = await DBHelper.getInstance();
    if (db != null) {
      coaches = await DBOperation.fetchCoaches(db);
      notifyListeners();
    }
  }

  // Getters for the images
  XFile? get idCardImage => _idCardImage;
  XFile? get bankPassbookImage => _bankPassbookImage;

  // Setters for the images
  set idCardImage(XFile? value) {
    _idCardImage = value;
    notifyListeners();
  }

  set bankPassbookImage(XFile? value) {
    _bankPassbookImage = value;
    notifyListeners();
  }
}
