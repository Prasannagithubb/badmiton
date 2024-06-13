import 'package:badmiton_app/constant/Screen.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 6.0,
          shadowColor: Colors.black,
          centerTitle: true,
          leading: const Icon(Icons.menu, color: Colors.white),
          title: const Text('Report',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          actions: [
            Padding(
              padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
              child: const Icon(Icons.search, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
              child: const Icon(Icons.notifications, color: Colors.white),
            ),
          ],
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Reports are shown here ',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ));
  }
}
