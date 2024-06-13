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
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.end,
        //     children: [
        //       FloatingActionButton(
        //         foregroundColor: Colors.white,
        //         backgroundColor: Colors.green,
        //         onPressed: () {
        //           print('add batch pressed');
        //         },
        //         child: const Icon(Icons.add),
        //       ),
        //     ],
        //   ),
        // ),
        // appBar: AppBar(
        //   elevation: 6.0,
        //   shadowColor: Colors.black,
        //   centerTitle: true,
        //   leading: const Icon(Icons.menu, color: Colors.white),
        //   title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
        //   actions: [
        //     Padding(
        //       padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
        //       child: const Icon(Icons.search, color: Colors.white),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
        //       child: const Icon(Icons.notifications, color: Colors.white),
        //     ),
        //   ],
        //   backgroundColor: Theme.of(context).primaryColor,
        // ),
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

