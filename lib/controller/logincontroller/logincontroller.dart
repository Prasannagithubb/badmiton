import 'package:flutter/material.dart';

class LoginCtrl with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userrnameCtrlr = TextEditingController();
  TextEditingController passWordCtrlr = TextEditingController();
}
