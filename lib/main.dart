import 'package:badmiton_app/controller/dashaddcoach.dart/dash_coach_provider.dart';
import 'package:badmiton_app/controller/dashbatchconroller/batch_list_provider.dart';
import 'package:badmiton_app/controller/dashstudentcontroller.dart/add_student_provider.dart';
import 'package:badmiton_app/controller/logincontroller/logincontroller.dart';
import 'package:badmiton_app/pages/screens/ConfigurationPage/screens/ConfigurationPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'Themes/theme_manager.dart';
import 'constant/AllRoutes.dart';
import 'controller/dashboardcontroller.dart/dash_board_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return MultiProvider(
      key: navigatorKey,
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
        ChangeNotifierProvider(
          create: (context) => BatchListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddStudentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginCtrl(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashboardProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashCoachProvider(),
        ),
      ],
      child: Consumer<ThemeManager>(builder: (context, themes, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Badmiton App',
          getPages: AllRoutes.allRoutes,
          theme: ThemeData(
            primaryColor: Colors.green.shade800,
            useMaterial3: true,
            // textTheme: GoogleFonts.nunitoSansTextTheme(),
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF0A1172))
                    .copyWith(),
          ),
          // theme: themes.selectedTheme == 'yellow'
          //     ? yellowTheme(context)
          //     : themes.selectedTheme == 'blue'
          //         ? blueTheme(context)
          //         : themes.selectedTheme == 'green'
          //             ? greenTheme(context)
          //             : themes.selectedTheme == 'red'
          //                 ? redTheme(context)
          //                 : roseTheme(context),
          home: const ConfigurationPage(),
        );
      }),
    );
  }
}
