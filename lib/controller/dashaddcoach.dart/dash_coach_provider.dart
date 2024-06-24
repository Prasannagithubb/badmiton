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
  List<TextEditingController> coachController = List.generate(10, (i) => TextEditingController());
  DateTime? dateOfJoining;
  DateTime? dateOfResignation;
  XFile? idCardImage;
  XFile? bankPassbookImage;
  bool coachCondition = true;
  List<Coach> coaches = [];
  final FocusNode dateOfJoiningFocusNode = FocusNode();
  final FocusNode dateOfresignationFocusNode = FocusNode();

  void init() {
    clearAll();
    fetchCoaches();
  }

  void clearAll() {
    coachController = List.generate(10, (i) => TextEditingController());
    coachCondition = false;
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
      final Database? db = await DBHelper.getInstance();
      if (db != null && coaches[index].id != null) {
        await DBOperation.deleteCoach(db, coaches[index].id!);
        fetchCoaches();
        notifyListeners();
      }
      notifyListeners();
    }
  }

  Future<void> updateCoach(context,
      {required String idCardPath, required String bankPassbookPath}) async {
    if (indexStudent != null) {
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
          fetchCoaches();
        }
      } catch (e) {
        log('Error updating coach: $e');
      }
    } else {
      log('Error: indexStudent is null');
    }
  }

  void editCoach(Coach coach, int i) {
    coachCondition = false;
    indexStudent = i;
    coachController[0].text = coach.name;
    coachController[1].text = coach.mobile;
    coachController[2].text = coach.salary;
    coachController[3].text = coach.bankDetails;
    coachController[4].text = coach.dateOfJoining;
    coachController[5].text = coach.dateOfResignation;
    idCardImage = XFile(coach.idCardPath);
    bankPassbookImage = XFile(coach.bankPassbookPath);
    notifyListeners();
  }

  void toggleCoachCondition(BuildContext context) {
    if (coachCondition) {
      log('Adding a new coach...');
      saveForm(idCardImage!.path, bankPassbookImage!.path);
    } else {
      log('Updating an existing coach...');
      updateCoach(context,
          idCardPath: idCardImage!.path,
          bankPassbookPath: bankPassbookImage!.path);
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
  XFile? get getidCardImage => idCardImage;
  XFile? get getbankPassbookImage => bankPassbookImage;

  // Setters for the images
  set setidCardImage(XFile? value) {
    idCardImage = value;
    notifyListeners();
  }

  set setbankPassbookImage(XFile? value) {
    bankPassbookImage = value;
    notifyListeners();
  }
}
