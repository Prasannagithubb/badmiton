import 'dart:developer';

import 'package:badmiton_app/constant/ConstantRoutes.dart';
import 'package:badmiton_app/constant/Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../controller/dashbatchconroller/batch_list_provider.dart';
import '../../../../controller/dashboardcontroller.dart/dash_board_provider.dart';
import '../../DashStudent/screens/batchaddstudent.dart';

class DashBatch extends StatefulWidget {
  const DashBatch({super.key});

  @override
  State<DashBatch> createState() => DashBatchState();
}

class DashBatchState extends State<DashBatch> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BatchListProvider>().init();
      context.read<BatchListProvider>().fetchBatchess();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              onPressed: () {
                setState(() {
                  log('select index::${DashboardProvider.selectedIndex}');
                });
                context.read<BatchListProvider>().clearAll();
                Get.toNamed(ConstantRoutes.addbatch);

                print('add batch pressed');
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 6.0,
        shadowColor: Colors.black,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text('Batchs',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Screens.bodyheight(context) * 0.01),
            context.watch<BatchListProvider>().batches.isEmpty
                ? Center(
                    child: Text(
                      'Press + Add a new Batch',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                    itemCount:
                        context.watch<BatchListProvider>().batches.length,
                    itemBuilder: (context, index) {
                      // final batch =
                      //     context.watch<BatchListProvider>().batches[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.white, Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                      'lib/assets/Badmiton_pure.png'),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context
                                            .watch<BatchListProvider>()
                                            .batches[index]
                                            .name
                                            .toUpperCase(),
                                        style: theme.textTheme.titleMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        context
                                            .watch<BatchListProvider>()
                                            .batches[index]
                                            .description,
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        context
                                            .watch<BatchListProvider>()
                                            .getSelectedDays(context
                                                .watch<BatchListProvider>()
                                                .batches[index]
                                                .batchDays),
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            ConstantRoutes.takeattendance);
                                      },
                                      child: const Icon(
                                        Icons.check_circle,
                                        color: Colors.greenAccent,
                                        size: 26,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<BatchListProvider>()
                                            .clearAdd();
                                        context
                                                .read<BatchListProvider>()
                                                .selectedBatch =
                                            context
                                                .read<BatchListProvider>()
                                                .batches[index]
                                                .name;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BatchAddStudent(),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.person_add,
                                        color: Colors.blueAccent,
                                        size: 26,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  "Delete Confirmation"),
                                              content: const Text(
                                                  "Are you sure you want to delete this batch?"),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Dismiss the dialog
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            BatchListProvider>()
                                                        .deleteBatch(index);
                                                    Navigator.of(context)
                                                        .pop(); // Dismiss the dialog
                                                  },
                                                  child: const Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                        size: 26,
                                      ),
                                    ),
                                  ],
                                ),
                                const Column(
                                  children: [
                                    SizedBox(width: 10),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )),
          ],
        ),
      ),
    );
  }
}
