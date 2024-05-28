// ignore_for_file: prefer_const_constructors
import 'dart:developer';
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:badmiton_app/pages/addcoach/addcoachpage.dart';
import 'package:badmiton_app/pages/screens/DashFees/screens/dashfees.dart';
import 'package:badmiton_app/pages/screens/DashHome/screens/dashhome.dart';
import 'package:badmiton_app/pages/screens/DashStudent/screens/dashstudent.dart';
import 'package:badmiton_app/pages/screens/dashbatch/screens/dashbatch.dart';
import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  static int selectedIndex = 0;
  // final NotchBottomBarController notchController =
  //     NotchBottomBarController(index: 0);
  PageController bottomSelectedIndex = PageController(initialPage: 0);
  List<Widget> pages = <Widget>[
    DashHome(),
    DashBatch(),
    DashStuddent(),
    CoachListScreen(),
    DashBoardFees(),
    DashHome(),
  ];
  void onItemTapped(int index) {
    log('index::$index');
    selectedIndex = index;
    notifyListeners();
  }

}
