import 'dart:developer';

import 'package:badmiton_app/constant/ConstantRoutes.dart';
import 'package:badmiton_app/dbmodel/addstudentmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../constant/Screen.dart';
import '../../../../controller/dashstudentcontroller.dart/add_student_provider.dart';

class DashStuddent extends StatefulWidget {
  const DashStuddent({super.key});

  @override
  State<DashStuddent> createState() => _DashStuddentState();
}

class _DashStuddentState extends State<DashStuddent> {
  bool isTapped = true;
  bool isTappedinactive = true;
  String studentName = "Student name";
  String batchName = "Batch name";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AddStudentProvider>().clearAll;
      context.read<AddStudentProvider>().fetchStudents();
      log("addstudents.length::${context.read<AddStudentProvider>().addstudents.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Addstudent> inactiveStudents = context
        .watch<AddStudentProvider>()
        .addstudents
        .where((s) => !s.isActive)
        .toList();
    // final addStudentProvider = Provider.of<AddStudentProvider>(context);
    // final batchProvider = Provider.of<BatchListProvider>(context);
    // List<Batch> batches = Provider.of<BatchListProvider>(context).batches;
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<AddStudentProvider>().clearAll();
              // Navigator.push(
              context.read<AddStudentProvider>().studentcondition = true;
              Get.toNamed(ConstantRoutes.addstudent1);
            }),
      ),
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 6.0,
        shadowColor: Colors.black,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text('Students',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: Screens.bodyheight(context) * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'All Students',
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.020,
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.055,
                width: Screens.width(context) * 0.80,
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Search students',
                    // hintText: 'Enter studen',
                    suffixIcon: Icon(Icons.search), // Using a filter icon
                    border:
                        OutlineInputBorder(), // Adds a border to the TextFormField
                  ),
                ),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.002,
              ),
              // const Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Text(
              //       'Filter applied : ',
              //       style: TextStyle(color: Colors.red),
              //     ),
              //     Text('Enrolled Days - Thu'),
              //   ],
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active: ${context.watch<AddStudentProvider>().addstudents.where((s) => s.isActive).length}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  // Consumer<AddStudentProvider>(
                  //   builder: (context, provider, child) {
                  //     return
                  // Text(
                  //       'Active: ${context.watch<AddStudentProvider>().addstudents.length}', // Accessing activeCount directly from provider
                  //       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //           color: Colors.green, fontWeight: FontWeight.bold),
                  //     );
                  //   },
                  // ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isTapped = !isTapped;
                      });
                    },
                    icon: Icon(
                      isTapped
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.black,
                      size: 27,
                    ),
                  ),
                ],
              ),

              if (isTapped)
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: context
                          .watch<AddStudentProvider>()
                          .addstudents
                          .where((s) => s.isActive)
                          .length,
                      itemBuilder: (BuildContext context, index) {
                        List<Addstudent> activeStudents = context
                            .watch<AddStudentProvider>()
                            .addstudents
                            .where((s) => s.isActive)
                            .toList();
                        var student = activeStudents[index];
                        return Column(
                          children: [
                            Container(
                                height: Screens.bodyheight(context) *
                                    0.1, // Increased height for better layout
                                width: Screens.width(context),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    // Enhancing shadow for 3D effect
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.7),
                                      // spreadRadius: 1,
                                      // blurRadius: 3,
                                      // offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          8.0), // Horizontal padding for internal spacing
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        child: Text(
                                          context
                                                  .watch<AddStudentProvider>()
                                                  .addstudents[index]
                                                  .studentname[
                                              0], // Display the first letter of the student name
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.green.shade800),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            context
                                                .watch<AddStudentProvider>()
                                                .addstudents[index]
                                                .studentname,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            context
                                                .watch<AddStudentProvider>()
                                                .addstudents[index]
                                                .batchname,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.green[
                                                  700], // A richer shade of green
                                              size:
                                                  30, // Slightly larger icon size
                                            ),
                                            onPressed: () {
                                              context
                                                  .read<AddStudentProvider>()
                                                  .editstudent(
                                                      context
                                                          .read<
                                                              AddStudentProvider>()
                                                          .addstudents[index],
                                                      index);
                                              Get.toNamed(
                                                  ConstantRoutes.addstudent1);
                                            },
                                            splashColor: Colors
                                                .greenAccent, // Splash color on press
                                            highlightColor: Colors
                                                .transparent, // No highlight color
                                          ),
                                          Ink(
                                            decoration: BoxDecoration(
                                              color: Colors.red[
                                                  100], // Light red background
                                              shape: BoxShape
                                                  .circle, // Circular shape for the ink response
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: const Offset(
                                                      0, 2), // Shadow position
                                                ),
                                              ],
                                            ),
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red[
                                                    800], // Darker shade of red for the icon
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                int actualIndex = context
                                                    .read<AddStudentProvider>()
                                                    .addstudents
                                                    .indexOf(student);
                                                Provider.of<AddStudentProvider>(
                                                        context,
                                                        listen: false)
                                                    .toggleStudentActive(
                                                        actualIndex);
                                              },
                                              splashColor: Colors.white.withOpacity(
                                                  0.5), // White splash for contrast
                                              highlightColor:
                                                  Colors.transparent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }),
                ),

              // if (isTapped) Accontainer(),
              // if (isTapped && batches.isNotEmpty) const Accontainer(),

              SizedBox(
                height: Screens.bodyheight(context) * 0.002,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Inactive : ${inactiveStudents.length}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isTappedinactive = !isTappedinactive;
                      });
                    },
                    icon: Icon(
                      isTappedinactive
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.black,
                      size: 27,
                    ),
                  ),
                ],
              ),
              if (isTappedinactive)
                Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // height: itemCount * itemHeight,
                      itemCount: inactiveStudents.length,
                      itemBuilder: (BuildContext context, index) {
                        var inactiveStudents = context
                            .watch<AddStudentProvider>()
                            .addstudents
                            .where((s) => !s.isActive)
                            .toList();
                        Addstudent student = inactiveStudents[index];
                        return Column(
                          children: [
                            Container(
                                height: Screens.bodyheight(context) *
                                    0.1, // Increased height for better layout
                                width: Screens.width(context),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    // Enhancing shadow for 3D effect
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.7),
                                      // spreadRadius: 1,
                                      // blurRadius: 3,
                                      // offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal:
                                          8.0), // Horizontal padding for internal spacing
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.white,
                                        child: Text(
                                          student.studentname[
                                              0], // Display the first letter of the student name
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.green.shade800),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            student.studentname,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            student.batchname,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.green[
                                                  700], // A richer shade of green
                                              size:
                                                  30, // Slightly larger icon size
                                            ),
                                            onPressed: () {
                                              // Handle edit operation
                                            },
                                            splashColor: Colors
                                                .greenAccent, // Splash color on press
                                            highlightColor: Colors
                                                .transparent, // No highlight color
                                          ),
                                          Ink(
                                            decoration: BoxDecoration(
                                              color: Colors.red[
                                                  100], // Light red background
                                              shape: BoxShape
                                                  .circle, // Circular shape for the ink response
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 3,
                                                  offset: const Offset(
                                                      0, 2), // Shadow position
                                                ),
                                              ],
                                            ),
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red[
                                                    800], // Darker shade of red for the icon
                                                size: 30,
                                              ),
                                              onPressed: () {
                                                // Convert local index to global index if needed
                                                int globalIndex = context
                                                    .read<AddStudentProvider>()
                                                    .addstudents
                                                    .indexOf(student);
                                                Provider.of<AddStudentProvider>(
                                                        context,
                                                        listen: false)
                                                    .deleteStudent(globalIndex);
                                              },
                                              splashColor: Colors.white.withOpacity(
                                                  0.5), // White splash for contrast
                                              highlightColor:
                                                  Colors.transparent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
