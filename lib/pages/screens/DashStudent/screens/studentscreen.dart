import 'package:badmiton_app/constant/ConstantRoutes.dart';
import 'package:badmiton_app/constant/Screen.dart';
import 'package:badmiton_app/controller/dashstudentcontroller.dart/add_student_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class StudentScreen extends StatefulWidget {
  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<AddStudentProvider>().fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                TabBar(
                  indicatorColor: Colors.green,
                  labelColor: Colors.green,
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Active'),
                    Tab(text: 'Inactive'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      Active(),
                      Inactive(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Active extends StatefulWidget {
  const Active({super.key});

  @override
  State<Active> createState() => _ActiveState();
}

class _ActiveState extends State<Active> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              context.watch<AddStudentProvider>().isActAddstudents.length,
          itemBuilder: (BuildContext context, index) {
            // List<Addstudent> activeStudents =
            //     context.watch<AddStudentProvider>().isActAddstudents.toList();
            // var student = activeStudents[index];
            return Column(
              children: [
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Text(
                              context
                                      .watch<AddStudentProvider>()
                                      .isActAddstudents[index]
                                      .studentname[
                                  0], // Display the first letter of the student name
                              style: TextStyle(
                                  fontSize: 24, color: Colors.green.shade800),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                context
                                    .watch<AddStudentProvider>()
                                    .isActAddstudents[index]
                                    .studentname,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                context
                                    .watch<AddStudentProvider>()
                                    .isActAddstudents[index]
                                    .batchname,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors
                                      .green[700], // A richer shade of green
                                  size: 30, // Slightly larger icon size
                                ),
                                onPressed: () {
                                  context
                                      .read<AddStudentProvider>()
                                      .editstudent(
                                          context
                                              .read<AddStudentProvider>()
                                              .isActAddstudents[index],
                                          index);
                                  Get.toNamed(ConstantRoutes.addstudent1);
                                },
                                splashColor:
                                    Colors.greenAccent, // Splash color on press
                                highlightColor:
                                    Colors.transparent, // No highlight color
                              ),
                              Ink(
                                decoration: BoxDecoration(
                                  color:
                                      Colors.red[100], // Light red background
                                  shape: BoxShape
                                      .circle, // Circular shape for the ink response
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset:
                                          const Offset(0, 2), // Shadow position
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
                                    // int actualIndex = context
                                    //     .read<AddStudentProvider>()
                                    //     .addstudents
                                    //     .indexOf(student);
                                    context
                                        .read<AddStudentProvider>()
                                        .toggleStudentActive(context
                                            .read<AddStudentProvider>()
                                            .isActAddstudents[index]
                                            .id!);
                                  },
                                  splashColor: Colors.white.withOpacity(
                                      0.5), // White splash for contrast
                                  highlightColor: Colors.transparent,
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
    );
  }
}

class Inactive extends StatefulWidget {
  const Inactive({super.key});

  @override
  State<Inactive> createState() => _InactiveState();
}

class _InactiveState extends State<Inactive> {
  @override
  Widget build(BuildContext context) {
    // List<Addstudent> inactiveStudents = context
    //     .watch<AddStudentProvider>()
    //     .addstudents
    //     .where((s) => s.isActive == "InActive")
    //     .toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: Screens.bodyheight(context) * 0.003,
          ),
          Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // height: itemCount * itemHeight,
                itemCount:
                    context.watch<AddStudentProvider>().inActAddstudents.length,
                itemBuilder: (BuildContext context, index) {
                  // var inactiveStudents = context
                  //     .watch<AddStudentProvider>()
                  //     .addstudents
                  //     .where((s) => s.isActive == "InActive")
                  //     .toList();
                  // Addstudent student = inactiveStudents[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    context
                                        .watch<AddStudentProvider>()
                                        .inActAddstudents[index]
                                        .studentname[0]
                                        .toUpperCase(), // Display the first letter of the student name
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.green.shade800),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      context
                                          .watch<AddStudentProvider>()
                                          .inActAddstudents[index]
                                          .studentname,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      context
                                          .watch<AddStudentProvider>()
                                          .inActAddstudents[index]
                                          .batchname,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.green[
                                            700], // A richer shade of green
                                        size: 30, // Slightly larger icon size
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
                                          color: Colors
                                              .red[100], // Light red background
                                          shape: BoxShape
                                              .circle, // Circular shape for the ink response
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.5),
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
                                            // int actualIndex = context
                                            //     .read<AddStudentProvider>()
                                            //     .addstudents
                                            //     .indexOf(student);
                                            context
                                                .read<AddStudentProvider>()
                                                .deleteStudent(context
                                                    .watch<AddStudentProvider>()
                                                    .inActAddstudents[index]
                                                    .id!);
                                          },
                                          splashColor: Colors.white.withOpacity(
                                              0.5), // White splash for contrast
                                          highlightColor: Colors.transparent,
                                        )),

                                    // onPressed: () {
                                    //           int actualIndex = context
                                    //               .read<AddStudentProvider>()
                                    //               .addstudents
                                    //               .indexOf(student);
                                    //           Provider.of<AddStudentProvider>(
                                    //                   context,
                                    //                   listen: false)
                                    //               .toggleStudentActive(
                                    //                   actualIndex);
                                    //         },
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
    );
  }
}
