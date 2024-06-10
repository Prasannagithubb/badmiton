

                                // Get.toNamed(ConstantRoutes.dashboard);
//  height: Screens.bodyheight(context) * 0.2,
//               width: Screens.width(context),


                // TextFormField(
                //     cursorColor: Colors.blue,
                //     controller:
                //         context.read<BatchListProvider>().mycontroller[2],
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter the fees amount';
                //       }
                //       return null;
                //     },
                //     decoration: InputDecoration(
                //       labelText: 'Fees',
                //       labelStyle: const TextStyle(color: Colors.grey),

                //       enabledBorder: OutlineInputBorder(
                //         borderSide: const BorderSide(color: Colors.transparent),
                //         borderRadius: BorderRadius.circular(5.5),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: const BorderSide(color: Colors.transparent),
                //         borderRadius: BorderRadius.circular(5.5),
                //       ),
                //       prefixIcon: const Icon(Icons.currency_rupee_rounded,
                //           color: Colors.blue),
                //       // hintText: "Enter your Name",
                //       hintStyle: const TextStyle(color: Colors.blue),
                //       filled: true,
                //       fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                //     ),
                //     keyboardType: TextInputType.number,
                //   ),


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
//   /// Controller to handle PageView and also handles initial page
//   int bottomSelectedIndex = 0;

//   /// Controller to handle bottom nav bar and also handles initial page
//   final NotchBottomBarController _controller =
//       NotchBottomBarController(index: 0);

//   int maxCount = 5;

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   void pageChanged(int index) {
//     setState(() {
//       bottomSelectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     /// widget list
//     // final List<Widget> bottomBarPages = [
//     //   const DashHome(),
//     //   const DashBatch(),
//     //   const DashStuddent(),
//     //   const DashBoardFees(),
//     //   const Page5(),
//     // ];
//     final pages = context.watch<DashboardProvider>().pages;

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 6.0,
//         shadowColor: Colors.black,
//         centerTitle: true,
//         leading: const Icon(
//           Icons.menu,
//           color: Colors.white,
//         ),
//         title: const Text(
//           'Dashboard',
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           Padding(
//             padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
//             child: const Icon(
//               Icons.search,
//               color: Colors.white,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
//             child: const Icon(
//               Icons.notifications,
//               color: Colors.white,
//             ),
//           ),
//         ],
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: PageView(
        
//         controller: _pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         onPageChanged: (index) {
//           pageChanged(index);
//         },
//         children: List.generate(pages.length, (index) => pages[index]),
//       ),
//       extendBody: true,
//       bottomNavigationBar: (pages.length <= maxCount)
//           ? AnimatedNotchBottomBar(
//               /// Provide NotchBottomBarController
//               notchBottomBarController: _controller,
//               color: Colors.white,
//               showLabel: true,
//               textOverflow: TextOverflow.visible,
//               maxLine: 1,
//               shadowElevation: 5,
//               kBottomRadius: 28.0,

//               // notchShader: const SweepGradient(
//               //   startAngle: 0,
//               //   endAngle: pi / 2,
//               //   colors: [Colors.red, Colors.green, Colors.orange],
//               //   tileMode: TileMode.mirror,
//               // ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
//               notchColor: Colors.white,

//               /// restart app if you change removeMargins
//               removeMargins: false,
//               bottomBarWidth: 500,
//               showShadow: true,
//               durationInMilliSeconds: 300,

//               itemLabelStyle: const TextStyle(fontSize: 10),

//               elevation: 1,
//               bottomBarItems: [
//                 BottomBarItem(
//                   inActiveItem: const Icon(
//                     Icons.home_rounded,
//                     color: Colors.blueGrey,
//                   ),
//                   activeItem: Icon(
//                     Icons.home_filled,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   itemLabel: 'Home',
//                 ),
//                 //  DashBatch //
//                 BottomBarItem(
//                   inActiveItem: const Icon(Icons.batch_prediction,
//                       color: Colors.blueGrey),
//                   activeItem: Icon(
//                     Icons.batch_prediction,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   itemLabel: 'Batch',
//                 ),
//                 //  Dashstudent //
//                 BottomBarItem(
//                   inActiveItem: const Icon(
//                     Icons.people_sharp,
//                     color: Colors.blueGrey,
//                   ),
//                   activeItem: Icon(
//                     Icons.people_sharp,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   itemLabel: 'Student',
//                 ),
//                 //  DashFees //
//                 BottomBarItem(
//                   inActiveItem: const Icon(
//                     Icons.currency_rupee_sharp,
//                     color: Colors.blueGrey,
//                   ),
//                   activeItem: Icon(
//                     Icons.currency_rupee_sharp,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   itemLabel: 'Fees',
//                 ),
//                 //  Dashreport //
//                 BottomBarItem(
//                   inActiveItem: const Icon(
//                     Icons.report,
//                     color: Colors.blueGrey,
//                   ),
//                   activeItem: Icon(
//                     Icons.report,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   itemLabel: 'Reports',
//                 ),
//               ],
//               onTap: (index) {
//                 // log('current selected index $index');
//                 _pageController.jumpToPage(index);
//               },
//               kIconSize: 24.0,
//             )
//           : null,
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

              //     Checkbox(
              //       value: checkboxValues[3],
              //       onChanged: (bool? newValue) {
              //         setState(() {
              //           checkboxValues[3] = newValue ?? false;
              //         });
              //       },
              //     ),
              //     SizedBox(
              //         width: Screens.width(context) *
              //             0.001), // Add spacing between checkbox and text
              //     const Text('Thu'),
              //     Formdategap(context),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Checkbox(
              //       value: checkboxValues[4],
              //       onChanged: (bool? newValue) {
              //         setState(() {
              //           checkboxValues[4] = newValue ?? false;
              //         });
              //       },
              //     ),
              //     SizedBox(
              //         width: Screens.width(context) *
              //             0.001), // Add spacing between checkbox and text
              //     const Text('Fri'),
              //     Checkbox(
              //       value: checkboxValues[5],
              //       onChanged: (bool? newValue) {
              //         setState(() {
              //           checkboxValues[5] = newValue ?? false;
              //         });
              //       },
              //     ),
              //     SizedBox(
              //         width: Screens.width(context) *
              //             0.001), // Add spacing between checkbox and text
              //     const Text('Sat'),
              //     Checkbox(
              //       value: checkboxValues[6],
              //       onChanged: (bool? newValue) {
              //         setState(() {
              //           checkboxValues[6] = newValue ?? false;
              //         });
              //       },
              //     ),
              //     SizedBox(
              //         width: Screens.width(context) *
              //             0.001), // Add spacing between checkbox and text
              //     const Text('Sun'),
              //   ],
              // ),
              // const SizedBox(height: 15),
              // ToggleButtons(
              //   borderRadius: BorderRadius.circular(8),
              //   isSelected: [weekdays, weekends],
              //   onPressed: (int index) {
              //     setState(() {
              //       if (index == 0) {
              //         // Handle weekdays selection logic
              //         weekdays = !weekdays;
              //         if (weekdays) {
              //           // If weekdays is selected, set all weekdays to true
              //           checkboxValues[0] = true; // Monday
              //           checkboxValues[1] = true;
              //           checkboxValues[2] = true;
              //           checkboxValues[3] = true;
              //           checkboxValues[4] = true;
              //         } else {
              //           // If weekdays is deselected, set all weekdays to false
              //           checkboxValues[0] = false; // Monday
              //           checkboxValues[1] = false;
              //           checkboxValues[2] = false;
              //           checkboxValues[3] = false;
              //           checkboxValues[4] = false;
              //         }
              //       } else {
              //         // Handle weekends selection logic
              //         weekends = !weekends;
              //         if (weekends) {
              //           // If weekends is selected, set Saturday and Sunday checkboxes to true
              //           checkboxValues[5] = true; // Saturday
              //           checkboxValues[6] = true; // Sunday
              //         } else {
              //           // If weekends is deselected, set Saturday and Sunday checkboxes to false
              //           checkboxValues[5] = false; // Saturday
              //           checkboxValues[6] = false; // Sunday
              //         }
              //       }
              //     });
              //   },
              //   children: const <Widget>[
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 16),
              //       child: Text('Weekdays'),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 16),
              //       child: Text('Weekends'),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 15),
              // TextFormField(
              //   controller: feesController,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter the fees amount';
              //     }
              //     return null;
              //   },
              //   decoration: const InputDecoration(
              //     labelText: 'Fees',
              //     // Add bottom border only
              //     border: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.grey),
              //     ),
              //   ),
              //   keyboardType: TextInputType.number,
              // ),
              // const SizedBox(height: 15),
              // TextFormField(
              //   controller: phoneController,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter the phone number';
              //     }
              //     return null;
              //   },
              //   decoration: const InputDecoration(
              //     labelText: 'Phone Number',
              //     // Add bottom border only
              //     border: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.grey),
              //     ),
              //   ),
              //   keyboardType: TextInputType.phone,
              // ),
              // const SizedBox(height: 15),
              // TextFormField(
              //   controller: altPhoneController,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter the Alternate Number';
              //     }
              //     return null;
              //   },
              //   decoration: const InputDecoration(
              //     labelText: 'Alternate Number',
              //     // Add bottom border only
              //     border: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.grey),
              //     ),
              //   ),
              //   keyboardType: TextInputType.phone,
              // ),
              // const SizedBox(height: 15),
          
              // Row(
              //   children: [
              //     Expanded(
              //       child: TextFormField(
              //         controller:
              //             dateOfJoiningController, // Use the new controller here
              //         decoration: const InputDecoration(
              //           labelText: 'Date of Joining',
              //           // Add bottom border only
              //           border: UnderlineInputBorder(
              //             borderSide: BorderSide(color: Colors.grey),
              //           ),
              //         ),
              //         onTap:
              //             _pickDateOfJoining, // Use the picker function on tap
              //         readOnly: true, // Prevent manual editing
              //         validator: (value) {
              //           if (value == null || value.isEmpty) {
              //             return 'Please enter the Date of Joining';
              //           }
              //           return null;
              //         },
              //       ),
              //     ),
              //     const SizedBox(width: 10),
              //     Expanded(
              //       child: TextFormField(
              //         controller:
              //             dateOfBirthController, // Use the controller here
              //         decoration: const InputDecoration(
              //           labelText: 'Date of Birth',
              //           // Add bottom border only
              //           border: UnderlineInputBorder(
              //             borderSide: BorderSide(color: Colors.grey),
              //           ),
              //         ),
              //         onTap:
              //             _pickDateOfBirth, // Use the picker function on tap
              //         readOnly: true, // Prevent manual editing
              //         validator: (value) {
              //           if (value == null || value.isEmpty) {
              //             return 'Please enter the Date of Birth';
              //           }
              //           return null;
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 15),
              // TextFormField(
              //   controller: emailController,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter the Email';
              //     }
              //     return null;
              //   },
              //   decoration: const InputDecoration(
              //     labelText: 'Email',
              //     // Add bottom border only
              //     border: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.grey),
              //     ),
              //   ),
              //   keyboardType: TextInputType.emailAddress,
              // ),
              // const SizedBox(height: 15),
              // TextFormField(
              //   controller: notesController,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter the Notes';
              //     }
              //     return null;
              //   },
              //   decoration: const InputDecoration(
              //     labelText: 'Notes',
              //     // Add bottom border only
              //     border: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.grey),
              //     ),
              //   ),
              //   maxLines: 3,
              // ),
              // TextFormField(
                    //   cursorColor: Colors.blue,
                    //   // controller: context.read<BatchListProvider>().mycontroller[2],
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter the Date of Birth';
                    //     }
                    //     return null;
                    //   },
                    //   decoration: InputDecoration(
                    //     labelText: 'Date of Birth',
                    //     labelStyle: const TextStyle(color: Colors.grey),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: const BorderSide(color: Colors.transparent),
                    //       borderRadius: BorderRadius.circular(5.5),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: const BorderSide(color: Colors.transparent),
                    //       borderRadius: BorderRadius.circular(5.5),
                    //     ),
                    //     prefixIcon:
                    //         const Icon(Icons.calendar_today, color: Colors.blue),
                    //     // hintText: "Enter your Name",
                    //     hintStyle: const TextStyle(color: Colors.blue),
                    //     filled: true,
                    //     fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                    //   ),
                    //   keyboardType:
                    //       TextInputType.datetime, // Specify input type as datetime
                    // ),
                    // const SizedBox(height: 15),

                    // TextFormField(
                    //   controller: TextEditingController(
                    //     text: DateTime.now().toString(),
                    //   ),
                    //   cursorColor: Colors.blue,
                    //   decoration: InputDecoration(
                    //     labelText: 'Current Time',
                    //     labelStyle: const TextStyle(color: Colors.grey),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: const BorderSide(color: Colors.transparent),
                    //       borderRadius: BorderRadius.circular(5.5),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: const BorderSide(color: Colors.transparent),
                    //       borderRadius: BorderRadius.circular(5.5),
                    //     ),
                    //     prefixIcon:
                    //         const Icon(Icons.access_time, color: Colors.blue),
                    //     hintStyle: const TextStyle(color: Colors.blue),
                    //     filled: true,
                    //     fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                    //   ),
                    //   keyboardType:
                    //       TextInputType.datetime, // Specify input type as datetime
                    // ),
                    // const SizedBox(height: 15),

                    // CircleAvatar(
                    //             radius: 25,
                    //             backgroundColor: Colors.white,
                    //             child:
                    //                 Image.asset('lib/assets/Badmiton_pure.png'),
                    //           ),

                    //           column(
                    //            children :  [
                    //                 Text(
                    //             batch.name,
                    //             style: theme.textTheme.titleMedium?.copyWith(
                    //               fontWeight: FontWeight.bold,
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //           ])

                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               // const SizedBox(height: 4),
                                  // Text(
                                  //   batch.description,
                                  //   style: theme.textTheme.bodyMedium?.copyWith(
                                  //     color: Colors.black,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                                  // const SizedBox(height: 4),
                                  // Text(
                                  //   context
                                  //       .watch<BatchListProvider>()
                                  //       .getSelectedDays(batch.batchDays),
                                  //   style: theme.textTheme.bodyMedium?.copyWith(
                                  //     color: Colors.black,
                                  //     fontSize: 12,
                                  //   ),
                                  // ),
                    //             ],
                    //           ),

                              // Column(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceAround,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   // mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     // const SizedBox(height: 10),
                              //     GestureDetector(
                              //       onTap: () {
                              //         Get.toNamed(
                              //             ConstantRoutes.takeattendance);
                              //       },
                              //       child: Container(
                              //         height: 10,
                              //         child: const Icon(
                              //           Icons.check_circle,
                              //           color: Colors.greenAccent,
                              //         ),
                              //       ),
                              //     ),
                              //     const SizedBox(height: 10),
                              //     GestureDetector(
                              //       onTap: () {
                              //         context
                              //             .read<BatchListProvider>()
                              //             .clearAdd();
                              //         Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) =>
                              //                 const AddStudentForm(),
                              //           ),
                              //         );
                              //       },
                              //       child: Container(
                              //         height: 10,
                              //         child: const Icon(Icons.person_add,
                              //             color: Colors.blueAccent, size: 20),
                              //       ),
                              //     ),
                              //     const SizedBox(height: 10),
                              //     GestureDetector(
                              //       onTap: () {
                              //         context
                              //             .read<BatchListProvider>()
                              //             .deleteBatch(index);
                              //       },
                              //       child: Container(
                              //         height: 10,
                              //         child: const Icon(Icons.delete,
                              //             color: Colors.redAccent, size: 20),
                              //       ),
                              //     ),
                              //   ],
                              // ),





                              import 'package:flutter/material.dart';

/////////////////////////////////DASHFEES FOR ADMIN//////
                              ///
                              ///
                              ///
                              ///
                              ///import 'package:badmiton_app/constant/Screen.dart';
// import 'package:badmiton_app/pages/screens/DashFees/widgets/pendingtabview.dart';
// import 'package:flutter/material.dart';

// import '../widgets/paidtabview.dart';

// class DashBoardFees extends StatefulWidget {
//   const DashBoardFees({super.key});

//   @override
//   State<DashBoardFees> createState() => _DashBoardFeesState();
// }

// class _DashBoardFeesState extends State<DashBoardFees>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     print('TabController initialized');
//   }

//   @override
//   void dispose() {
//     print('Disposing TabController');
//     _tabController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('Building Widget');
//     if (_tabController == null) {
//       print('TabController is null when building widget');
//       return Container(); // Return an empty container to avoid errors.
//     }

//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         elevation: 6.0,
//         shadowColor: Colors.black,
//         centerTitle: true,
//         leading: const Icon(Icons.menu, color: Colors.white),
//         title: const Text('Fees', style: TextStyle(color: Colors.white)),
//         actions: [
//           Padding(
//             padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
//             child: const Icon(Icons.search, color: Colors.white),
//           ),
//           Padding(
//             padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
//             child: const Icon(Icons.notifications, color: Colors.white),
//           ),
//         ],
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             margin: const EdgeInsets.all(8.0),
//             height: Screens.bodyheight(context) * 0.06,
//             width: Screens.width(context) * 0.6,
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey
//                       .withOpacity(0.5), // Adjust the opacity as needed
//                   spreadRadius: 1, // Spread radius
//                   blurRadius: 6, // Blur radius
//                   offset: const Offset(0, 1), // changes position of shadow
//                 ),
//               ],
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ), // Optional: adds a background color to the TabBar container
//             child: TabBar(
//               controller: _tabController!,
//               labelColor: Colors.red,
//               unselectedLabelColor: Colors.grey,
//               indicatorColor: Colors.grey,
//               indicatorSize: TabBarIndicatorSize.tab,
//               indicatorPadding: const EdgeInsets.all(1.0),
//               tabs: const [
//                 Tab(text: 'Pending'),
//                 Tab(text: 'Paid'),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController!,
//               children: const [
//                 TabviewPending(),
//                 PaidTabView(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


