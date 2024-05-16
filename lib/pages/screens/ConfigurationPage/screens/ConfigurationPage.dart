import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/ConstantRoutes.dart';
import '../../../../constant/Screen.dart';
// import 'package:transportserviceapp/Constant/Screen.dart';
// import 'package:transportserviceapp/constant/ConstantRoutes.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  @override
  void initState() {
    super.initState();
    navigatetopush();
  }

  void navigatetopush() async {
    await Future.delayed(const Duration(seconds: 5));
    // Navigator.push(context,
    setState(() {
      Get.offAllNamed(ConstantRoutes.splash);
    });
    //     MaterialPageRoute(builder: (context) => const SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Screens.width(context),
        height: Screens.fullHeight(context),
      ),
    );
  }
}
