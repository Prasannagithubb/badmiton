import 'dart:developer';

import 'package:badmiton_app/Models/couchdata.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DashCoachProvider extends ChangeNotifier {
  int? indexstudent;
  final coachformKey = GlobalKey<FormState>();
  List<TextEditingController> coachcontroller =
      List.generate(10, (i) => TextEditingController());
  DateTime? dateOfJoining;
  DateTime? dateOfResignation;

  // XFile? _image; // This will hold the profile image file
  XFile? _idCardImage; // This will hold the ID card image file
  XFile? _bankPassbookImage; // This will hold the bank passbook image file
  // final ImagePicker _picker = ImagePicker(); // Create an ImagePicker instance

  // String? _idCardError;
  // String? _bankPassbookError;
  bool couchswitch = false;

  List<Coach> coaches = [];

  init() {
    clearAll();
  }

  clearAll() {
    coachcontroller = List.generate(50, (i) => TextEditingController());
    couchswitch = false;
    notifyListeners();
  }

  bool validateForm(
      {required bool isIdCardSelected, required bool isBankPassbookSelected}) {
    final formValid = coachformKey.currentState?.validate() ?? false;
    return formValid && isIdCardSelected && isBankPassbookSelected;
  }

  void removeCoach(int index) {
    coaches.removeAt(index);
    notifyListeners();
  }

  void updatedcouch(BuildContext context) {
    int i = indexstudent!;
    try {
      coaches[i].name = coachcontroller[0].text;
      coaches[i].mobile = coachcontroller[1].text.toString();
      if (_idCardImage != null) {
        coaches[i].idCardPath = _idCardImage!.path;
      }
      coaches[i].salary = coachcontroller[2].text.toString();
      coaches[i].bankDetails = coachcontroller[3].text;
      if (_bankPassbookImage != null) {
        coaches[i].bankPassbookPath = _bankPassbookImage!.name;
      }
      coaches[i].dateOfJoining = coachcontroller[4].text;
      coaches[i].dateOfResignation = coachcontroller[5].text;
      // coaches[i].dateOfResignation = DateTime.parse(coachcontroller[7].text);
      Navigator.pop(context);
      // coaches[i] = addstdn;
    } catch (e) {
      print('Error parsing values: $e');
    }
  }

  editCouch(Coach addcouch, int i) {
    log(couchswitch.toString());
    couchswitch = false;
    log(addcouch.name);
    indexstudent = i;
    coachcontroller[0].text = addcouch.name;
    coachcontroller[1].text = addcouch.mobile.toString();
    coachcontroller[2].text = addcouch.idCardPath;
    coachcontroller[2].text = addcouch.salary.toString();
    coachcontroller[3].text = addcouch.bankDetails;
    coachcontroller[5].text = addcouch.bankPassbookPath.toString();
    coachcontroller[4].text = addcouch.dateOfJoining.toString();
    coachcontroller[5].text = addcouch.dateOfResignation.toString();
    notifyListeners();
  }

  void couchupdate(
    BuildContext context,
    String idCardPath,
    String bankPassbookPath,
  ) {
    if (couchswitch == true) {
      saveForm(idCardPath, bankPassbookPath);
      notifyListeners();
    } else {
      updatedcouch(context );
    }
    notifyListeners();
  }

  void saveForm(
    String idCardPath,
    String bankPassbookPath,
  ) {
    if (validateForm(
        isIdCardSelected: idCardPath.isNotEmpty,
        isBankPassbookSelected: bankPassbookPath.isNotEmpty)) {
      coachformKey.currentState?.save();
      final coach = Coach(
        name: coachcontroller[0].text,
        mobile: coachcontroller[1].text,
        salary: coachcontroller[2].text,
        bankDetails: coachcontroller[3].text,
        dateOfJoining: coachcontroller[4].text,
        dateOfResignation: coachcontroller[5].text,
        idCardPath: idCardPath,
        bankPassbookPath: bankPassbookPath,
      );
      coaches.add(coach);
      notifyListeners();
    }
  }
}
