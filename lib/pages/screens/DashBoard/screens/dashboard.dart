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
              .widgetOptions
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

// import 'dart:developer';

// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:badmiton_app/constant/Screen.dart';
// import 'package:badmiton_app/controller/dashboardcontroller.dart/dash_board_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class DashBoard extends StatefulWidget {
//   const DashBoard({super.key});

//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }

// class _DashBoardState extends State<DashBoard> {
//   final NotchBottomBarController _controller =
//       NotchBottomBarController(index: 0);

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final pages = context.watch<DashboardProvider>().pages;

    // return Scaffold(
    //   appBar: AppBar(
    //     elevation: 6.0,
    //     shadowColor: Colors.black,
    //     centerTitle: true,
    //     leading: const Icon(Icons.menu, color: Colors.white),
    //     title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
    //     actions: [
    //       Padding(
    //         padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
    //         child: const Icon(Icons.search, color: Colors.white),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
    //         child: const Icon(Icons.notifications, color: Colors.white),
    //       ),
    //     ],
    //     backgroundColor: Theme.of(context).primaryColor,
    //   ),
    //   body: PageView(
//         controller: context.watch<DashboardProvider>().bottomSelectedIndex,
//         children: List.generate(context.watch<DashboardProvider>().pages.length,
//             (index) => context.watch<DashboardProvider>().pages[index]),
//         // children: context.watch<DashboardProvider>().pages,
//       ),
//       bottomNavigationBar: AnimatedNotchBottomBar(
//         notchBottomBarController: _controller,
//         color: Colors.white,
//         showLabel: true,
//         shadowElevation: 5,
//         bottomBarWidth: 500,
//         showShadow: true,
//         durationInMilliSeconds: 300,
//         itemLabelStyle: const TextStyle(fontSize: 10),
//         elevation: 1,
//         bottomBarItems: [
//           BottomBarItem(
//             inActiveItem:
//                 const Icon(Icons.home_rounded, color: Colors.blueGrey),
//             activeItem:
//                 Icon(Icons.home_filled, color: Theme.of(context).primaryColor),
//             itemLabel: 'Home',
//           ),
//           BottomBarItem(
//             inActiveItem:
//                 const Icon(Icons.batch_prediction, color: Colors.blueGrey),
//             activeItem: Icon(Icons.batch_prediction,
//                 color: Theme.of(context).primaryColor),
//             itemLabel: 'Batch',
//           ),
//           BottomBarItem(
//             inActiveItem:
//                 const Icon(Icons.people_sharp, color: Colors.blueGrey),
//             activeItem:
//                 Icon(Icons.people_sharp, color: Theme.of(context).primaryColor),
//             itemLabel: 'Student',
//           ),
//           BottomBarItem(
//             inActiveItem:
//                 const Icon(Icons.currency_rupee_sharp, color: Colors.blueGrey),
//             activeItem: Icon(Icons.currency_rupee_sharp,
//                 color: Theme.of(context).primaryColor),
//             itemLabel: 'Fees',
//           ),
//           BottomBarItem(
//             inActiveItem: const Icon(Icons.report, color: Colors.blueGrey),
//             activeItem:
//                 Icon(Icons.report, color: Theme.of(context).primaryColor),
//             itemLabel: 'Reports',
//           ),
//         ],
//         onTap: (index) {
//           log('current selected index $index');
//           context
//               .read<DashboardProvider>()
//               .bottomSelectedIndex
//               .jumpToPage(index);
//         },
//         kIconSize: 24.0,
//         kBottomRadius: 2.0,
//       ),
//     );
//   }
// }

// class Page5 extends StatelessWidget {
//   const Page5({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.white, child: const Center(child: Text('Page 5')));
//   }
// }
