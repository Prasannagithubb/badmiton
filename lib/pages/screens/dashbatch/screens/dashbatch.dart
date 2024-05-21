import 'dart:developer';

import 'package:badmiton_app/constant/ConstantRoutes.dart';
import 'package:badmiton_app/constant/Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../controller/dashbatchconroller/batch_list_provider.dart';
import '../../../../controller/dashboardcontroller.dart/dash_board_provider.dart';
import '../../Attendance/Widgets/batchaddstudent.dart';

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
                Get.toNamed(ConstantRoutes.addbatch);

                print('add batch pressed');
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 6.0,
        shadowColor: Colors.black,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text('Batch',
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
          mainAxisAlignment: MainAxisAlignment.start,
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
                // Row(
                //   children: [
                //     GestureDetector(
                //       onTap: () {
                //         // context.read<BatchListProvider>().clearAdd();
                //         setState(() {
                //           log('select index::${DashboardProvider.selectedIndex}');
                //         });
                //         Get.toNamed(ConstantRoutes.addbatch);
                //         // Navigator.push(
                //         //     context,
                //         //     MaterialPageRoute(
                //         //         builder: (context) => DashBoard()));
                //         print('add batch pressed');
                //       },
                //       child: Container(
                //         height: Screens.bodyheight(context) * 0.04,
                //         width: Screens.width(context) * 0.20,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: Colors.green.shade400,
                //         ),
                //         child: const Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                //           children: [
                //             Icon(
                //               Icons.add,
                //               color: Colors.white,
                //             ),
                //             Text(
                //               'NEW',
                //               style: TextStyle(color: Colors.white),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.020,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: context.watch<BatchListProvider>().batches.length,
                itemBuilder: (context, index) {
                  final batch =
                      context.watch<BatchListProvider>().batches[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: Screens.bodyheight(context) * 0.18,
                      width: Screens.width(context),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.09),
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                          )
                        ],
                        image: const DecorationImage(
                          opacity: 0.1,
                          image: AssetImage("lib/assets/Badmiton_pure.png"),
                          alignment: Alignment.center,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  batch.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(batch.time),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Description',
                                        style:
                                            TextStyle(color: Colors.black26)),
                                    Text(batch.description),
                                    Text(context
                                        .watch<BatchListProvider>()
                                        .getSelectedDays(batch.batchDays)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<BatchListProvider>()
                                            .deleteBatch(index);
                                      },
                                      child: const Icon(Icons.delete,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                                height: Screens.bodyheight(context) * 0.014),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(ConstantRoutes.takeattendance);
                                  },
                                  child: const Text(
                                    'Take attendance',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.green,
                                      decorationThickness: 2,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<BatchListProvider>()
                                        .clearAdd();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddStudentForm()),
                                    );
                                  },
                                  child: const Text(
                                    'Add student',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.green,
                                      decorationThickness: 2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
