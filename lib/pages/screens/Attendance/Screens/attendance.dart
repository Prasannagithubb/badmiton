import 'package:badmiton_app/controller/dashstudentcontroller.dart/add_student_provider.dart';
import 'package:badmiton_app/dbmodel/addstudentmodel.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<Addstudent> students = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  void fetchStudents() async {
    final addStudentProvider =
        Provider.of<AddStudentProvider>(context, listen: false);
    await addStudentProvider.fetchStudents();
    setState(() {
      students = addStudentProvider.addstudents;
    });
  }

  void handleDateChange(DateTime selectedDate) {
    if (selectedDate.isAfter(DateTime.now())) {
      setState(() {
        selectedDate = DateTime.now();
      });
      print('Future dates are not allowed. Resetting to today\'s date.');
    } else {
      setState(() {
        selectedDate = selectedDate;
      });
      print('Selected date: $selectedDate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: Column(
        children: [
          EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: handleDateChange,
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
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white,
                      Colors.green,
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          const Center(
            child: Text('List of students'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    title: Text(
                      student.studentname,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      student.isActive ? 'Present' : 'Absent',
                      style: TextStyle(
                        color: student.isActive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Switch(
                      value: student.isActive,
                      onChanged: (bool value) {
                        setState(() {
                          student.isActive = value;
                        });
                      },
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey[300],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
