import 'package:badmiton_app/Models/batchcontainer.dart';
import 'package:badmiton_app/constant/ConstantRoutes.dart';
import 'package:badmiton_app/constant/Screen.dart';
import 'package:badmiton_app/controller/dashbatchconroller/batch_list_provider.dart';
import 'package:badmiton_app/pages/screens/Attendance/Widgets/batchaddstudent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BatchContainer extends StatelessWidget {
  const BatchContainer({
    super.key,
    required this.batch,
    required this.i,
  });

  final Batch batch;
  final int i;

  String _getSelectedDays(List<bool> batchDays) {
    List<String> dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    List<String> selectedDays = [];

    for (int i = 0; i < batchDays.length; i++) {
      if (batchDays[i]) {
        selectedDays.add(dayNames[i]);
      }
    }

    return selectedDays.join(' ');
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    '${batch.time}.${batch.time} ${batch.time == DayPeriod.am ? 'AM' : 'PM'}',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(color: Colors.black26),
                      ),
                      Text(batch.description),
                      Text(
                        _getSelectedDays(batch.batchDays),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.read<BatchListProvider>().deleteBatch(i);
                          // deleteBatch(context, batch);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.014,
              ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddStudentForm()));
                      // Get.toNamed(ConstantRoutes.);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
