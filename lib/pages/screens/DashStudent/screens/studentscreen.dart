import 'dart:developer';

import 'package:badmiton_app/constant/ConstantRoutes.dart';
import 'package:badmiton_app/constant/Screen.dart';
import 'package:badmiton_app/controller/dashstudentcontroller.dart/add_student_provider.dart';
import 'package:badmiton_app/dbmodel/addstudentmodel.dart';
import 'package:badmiton_app/pages/screens/DashStudent/widgets/addstudent1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<AddStudentProvider>().init(context);
    _searchController.addListener(_updateSearchQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateSearchQuery() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  List<Addstudent> _filterStudents(List<Addstudent> students) {
    if (_searchQuery.isEmpty) {
      return students;
    } else {
      return students
          .where((student) =>
              student.studentname.toLowerCase().contains(_searchQuery) ||
              student.batchname.toLowerCase().contains(_searchQuery))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeStudents =
        _filterStudents(context.watch<AddStudentProvider>().isActAddstudents);
    final inactiveStudents =
        _filterStudents(context.watch<AddStudentProvider>().inActAddstudents);

    return Scaffold(
      backgroundColor: Colors.grey,
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
                    controller: _searchController,
                    cursorColor: Colors.green,
                    decoration: const InputDecoration(
                      focusColor: Colors.green,
                      focusedBorder: OutlineInputBorder(),
                      labelText: 'Search students',
                      labelStyle: TextStyle(color: Colors.black),
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
                    children: [
                      Active(students: activeStudents),
                      Inactive(students: inactiveStudents),
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

class Active extends StatelessWidget {
  final List<Addstudent> students;

  const Active({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: students.length,
        itemBuilder: (BuildContext context, index) {
          log('Active Students Length: ${students.length}');
          return Column(
            children: [
              SizedBox(height: Screens.bodyheight(context) * 0.01),
              Card(
                elevation: 4.0,
                child: Container(
                  height: Screens.bodyheight(context) * 0.1,
                  width: Screens.width(context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Image.asset('lib/assets/Badmiton_pure.png'),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              students[index].studentname,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              students[index].batchname,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.green[700],
                                size: 30,
                              ),
                              onPressed: () {
                                context
                                    .read<AddStudentProvider>()
                                    .editstudent(students[index], index);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddStudentForm1()));
                              },
                              splashColor: Colors.greenAccent,
                              highlightColor: Colors.transparent,
                            ),
                            Ink(
                              decoration: BoxDecoration(
                                color: Colors.red[100],
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red[800],
                                  size: 30,
                                ),
                                onPressed: () {
                                  context
                                      .read<AddStudentProvider>()
                                      .toggleStudentActive(
                                          context, students[index].id!);
                                },
                                splashColor: Colors.white.withOpacity(0.5),
                                highlightColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }
}

class Inactive extends StatelessWidget {
  final List<Addstudent> students;

  const Inactive({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Screens.bodyheight(context) * 0.003),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: students.length,
            itemBuilder: (BuildContext context, index) {
              log('Inactive Students Length: ${students.length}');
              return Column(
                children: [
                  Card(
                    elevation: 4.0,
                    child: Container(
                      height: Screens.bodyheight(context) * 0.1,
                      width: Screens.width(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child:
                                  Image.asset('lib/assets/Badmiton_pure.png'),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  students[index].studentname,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  students[index].batchname,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.green[700],
                                size: 30,
                              ),
                              onPressed: () {
                                context
                                    .read<AddStudentProvider>()
                                    .editstudent(students[index], index);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddStudentForm1()));
                              },
                              splashColor: Colors.greenAccent,
                              highlightColor: Colors.transparent,
                            ),
                            Ink(
                              decoration: BoxDecoration(
                                color: Colors.red[100],
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red[800],
                                  size: 30,
                                ),
                                onPressed: () {
                                  context
                                      .read<AddStudentProvider>()
                                      .toggleStudentActive(
                                          context, students[index].id!);
                                },
                                splashColor: Colors.white.withOpacity(0.5),
                                highlightColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Screens.bodyheight(context) * 0.01),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
