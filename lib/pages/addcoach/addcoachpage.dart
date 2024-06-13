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

  @override
  Widget build(BuildContext context) {
    final dashCoachProvider = Provider.of<DashCoachProvider>(context);
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
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
              context.read<DashCoachProvider>().coachCondition = true;
              Get.toNamed(ConstantRoutes.addCoachform);
            }),
      ),
      appBar: AppBar(
        elevation: 6.0,
        shadowColor: Colors.black,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text('Coach',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: const [],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Screens.bodyheight(context) * 0.01),
            dashCoachProvider.coaches.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: Screens.bodyheight(context) * 0.43),
                      Center(
                        child: Text(
                          'Press + Add a new coach',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(height: Screens.bodyheight(context) * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'All Coaches',
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
                          cursorColor: Colors.green,
                          decoration: const InputDecoration(
                            focusColor: Colors.green,
                            focusedBorder: OutlineInputBorder(),
                            labelText: 'Search Coaches',
                            labelStyle: TextStyle(color: Colors.black),
                            suffixIcon:Icon(Icons.search), // Using a filter icon
                            border: OutlineInputBorder(), // Adds a border to the TextFormField
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.004,
                      ),
                    ],
                  ),
            Expanded(
              child: ListView.builder(
                itemCount: dashCoachProvider.coaches.length,
                itemBuilder: (context, index) {
                  final coach = dashCoachProvider.coaches[index];
                  return Card(
                    elevation: 4.0,
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white, // Light grey color for each list item for better contrast
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: Image.asset('lib/assets/Badmiton_pure.png'),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:const EdgeInsets.symmetric(horizontal: 8.0),
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
                                    style: const TextStyle(color: Colors.black54),
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
                                context.read<DashCoachProvider>().editCoach(
                                    context.read<DashCoachProvider>().coaches[index],
                                    index);
                              });
                              context.read<DashCoachProvider>().coachCondition =
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
