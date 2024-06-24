import 'package:badmiton_app/constant/Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/ConstantRoutes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigatetopush();
  }

  void navigatetopush() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      Get.offAllNamed(ConstantRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: Screens.bodyheight(context) * 0.34,
          ),
          Image.asset(
              height: Screens.bodyheight(context) * 0.28,
              width: Screens.width(context) * 0.9,
              'lib/assets/Badmiton_logo-removebg-preview (1).png'),
          SizedBox(
            height: Screens.bodyheight(context) * 0.01,
          ),
          Center(
            child: SizedBox(
              width: Screens.width(context) * 0.2,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey[300], // Background color
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.red), // Red color for the progress indicator
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
