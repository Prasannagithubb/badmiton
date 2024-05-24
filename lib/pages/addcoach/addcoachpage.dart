import 'dart:developer';

import 'package:badmiton_app/constant/ConstantRoutes.dart';
import 'package:badmiton_app/constant/Screen.dart';
import 'package:badmiton_app/controller/dashaddcoach.dart/dash_coach_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'package:provider/provider.dart';

class CoachListScreen extends StatefulWidget {
  const CoachListScreen({super.key});

  @override
  State<CoachListScreen> createState() => _CoachListScreenState();
}

class _CoachListScreenState extends State<CoachListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashCoachProvider>().init();
    });
  }

  Widget build(BuildContext context) {
    final dashCoachProvider = Provider.of<DashCoachProvider>(context);
    ThemeData theme = Theme.of(context);

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
              context.read<DashCoachProvider>().clearAll();
              context.read<DashCoachProvider>().couchSwitch = true;
              Get.toNamed(ConstantRoutes.addCoachform);
            }),
      ),
      appBar: AppBar(
        elevation: 6.0,
        shadowColor: Colors.black,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text('Coach', style: TextStyle(color: Colors.white)),
        actions: [
          // IconButton(
          //   icon: const Icon(
          //     Icons.add,
          //     color: Colors.white,
          //   ),
          //   onPressed: () {
          //     context.read<DashCoachProvider>().clearAll();
          //     context.read<DashCoachProvider>().couchswitch = true;
          //     Get.toNamed(ConstantRoutes.addCoachform);
          //   },
          // ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Screens.bodyheight(context) * 0.01),
            dashCoachProvider.coaches.isEmpty
                ? Center(
                    child: Text(
                      'Press + Add a new coach',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: dashCoachProvider.coaches.length,
                      itemBuilder: (context, index) {
                        final coach = dashCoachProvider.coaches[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: const EdgeInsets.all(
                                8), // Adds space around each row for better clarity
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey
                                  .shade100, // Light grey color for each list item for better contrast
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: Text(
                                      coach.name[
                                          0], // First letter of the student's name
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          coach.name,
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          coach.mobile,
                                          style: const TextStyle(
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  onPressed: () {
                                    log(context
                                        .read<DashCoachProvider>()
                                        .coaches
                                        .length
                                        .toString());
                                    setState(() {
                                      context
                                          .read<DashCoachProvider>()
                                          .editCoach(
                                              context
                                                  .read<DashCoachProvider>()
                                                  .coaches[index],
                                              index);
                                    });
                                    context
                                        .read<DashCoachProvider>()
                                        .couchSwitch = false;
                                    Get.toNamed(ConstantRoutes.addCoachform);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () {
                                    dashCoachProvider.removeCoach(index);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
