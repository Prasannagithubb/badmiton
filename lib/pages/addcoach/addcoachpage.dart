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
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashCoachProvider>().init();
    });
  }

  Widget build(BuildContext context) {
    final dashCoachProvider = Provider.of<DashCoachProvider>(context);
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 6.0,
        shadowColor: Colors.black,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text('Couch', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              context.read<DashCoachProvider>().clearAll();
              context.read<DashCoachProvider>().couchswitch = true;
              Get.toNamed(ConstantRoutes.addCoachform);
            },
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // appBar: AppBar(
      //   title: const Text('Coach List'),

      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: Screens.bodyheight(context) * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'All Batches',
                      style: theme.textTheme.bodyMedium?.copyWith(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<DashCoachProvider>().clearAll();
                        Get.toNamed(ConstantRoutes.addCoachform);
                        context.read<DashCoachProvider>().couchswitch = true;
                      },
                      child: Container(
                        height: Screens.bodyheight(context) * 0.04,
                        width: Screens.width(context) * 0.20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade400,
                              Colors.green.shade600
                            ], // Two shades of green
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.shade800.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: const Offset(
                                  0, 2), // Changes position of shadow
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.add,
                                color: Colors.white,
                                size: 24), // Increased icon size
                            Text(
                              'New',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    16, // Increased font size for better visibility
                                fontWeight: FontWeight.bold, // Make text bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.010,
            ),
            Expanded(
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
                              backgroundColor: Theme.of(context).primaryColor,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    style:
                                        const TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit,
                                color: Theme.of(context).colorScheme.secondary),
                            onPressed: () {
                              log(context
                                  .read<DashCoachProvider>()
                                  .coaches
                                  .length
                                  .toString());
                              setState(() {
                                context.read<DashCoachProvider>().editCouch(
                                    context
                                        .read<DashCoachProvider>()
                                        .coaches[index],
                                    index);
                              });
                              context.read<DashCoachProvider>().couchswitch =
                                  false;
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
