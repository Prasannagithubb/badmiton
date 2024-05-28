import 'package:badmiton_app/pages/addcoach/addcoachform.dart';
import 'package:badmiton_app/pages/screens/Attendance/Screens/attendance.dart';
import 'package:badmiton_app/pages/screens/DashStudent/widgets/addstudent1.dart';
import 'package:badmiton_app/pages/screens/dashbatch/widgets/addbatch.dart';
import 'package:get/get.dart';
import '../pages/screens/Attendance/Widgets/batchaddstudent.dart';
import '../pages/screens/DashBoard/screens/dashboard.dart';
import '../pages/screens/Login/screens/loginscreen.dart';
import '../pages/screens/SplashScreen/pages/splashscreen.dart';
import 'ConstantRoutes.dart';

class AllRoutes {
  static List<GetPage> allRoutes = [
    GetPage<dynamic>(
        name: ConstantRoutes.addCoachform,
        page: () => const AddCouch(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.addstudent1,
        page: () => const AddStudentForm1(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.splash,
        page: () => const SplashScreen(),
        transition: Transition.fade,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.login,
        page: () => const LoginFormValidation(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.dashboard,
        page: () => const DashBoard(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.takeattendance,
        page: () => const AttendancePage(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.addstudent,
        page: () => const BatchAddStudent(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(seconds: 1)),
    GetPage<dynamic>(
        name: ConstantRoutes.addbatch,
        page: () => const AddBatch(),
        transition: Transition.cupertino,
        transitionDuration: const Duration(seconds: 1)),
  ];
}
