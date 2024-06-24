import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../controller/dashboardcontroller.dart/dash_board_provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: context
              .watch<DashboardProvider>()
              .pages
              .elementAt(DashboardProvider.selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.batch_prediction),
              label: 'Batch',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Student',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Coach',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.currency_rupee),
              label: 'Fees',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.report),
              label: 'Report',
            ),
          ],
          currentIndex: DashboardProvider.selectedIndex,
          selectedItemColor: Colors.green[800],
          onTap: (value) {
            setState(() {
              context.read<DashboardProvider>().onItemTapped(value);
            });
          },
        ));
  }
}

