import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import '../../../../constant/Screen.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  print('Save button pressed');
                },
                child: Text(
                  'Save',
                  style: theme.textTheme.bodyLarge,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              //`selectedDate` the new date selected.
            },
            headerProps: const EasyHeaderProps(
              monthPickerType: MonthPickerType.switcher,
              dateFormatter: DateFormatter.fullDateDMY(),
            ),
            dayProps: const EasyDayProps(
              dayStructure: DayStructure.dayStrDayNum,
              activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey,
                      Color.fromRGBO(207, 43, 33, 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Screens.bodyheight(context) * 0.020,
          ),
          const Center(
            child: Text('Attendance in this batch '),
          ),
        ],
      ),
    );
  }
}
