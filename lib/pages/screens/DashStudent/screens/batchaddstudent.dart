import 'dart:io';

import 'package:badmiton_app/constant/Screen.dart';
import 'package:badmiton_app/controller/dashbatchconroller/batch_list_provider.dart';
// import 'package:badmiton_app/controller/dashstudentcontroller.dart/add_student_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BatchAddStudent extends StatefulWidget {
  const BatchAddStudent({super.key});

  @override
  _BatchAddStudentState createState() => _BatchAddStudentState();
}

class _BatchAddStudentState extends State<BatchAddStudent> {
  DateTime? selectedDateOfBirth;
  XFile? _image; // This will hold the image file
  final ImagePicker _picker = ImagePicker(); // Create an ImagePicker instance
  final TextEditingController _dateController = TextEditingController();

  // Function to handle image picking
  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });
      }
    } catch (e) {
      print('Image picker error: $e');
    }
  }

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    _dateController.text =
        '${context.read<BatchListProvider>().studentcurrentTime.hour}.${context.read<BatchListProvider>().studentcurrentTime.minute}';
  }

  void updateTextController() {
    batchController.text = context.read<BatchListProvider>().selectedBatch ??
        ""; // Set controller text to the selected batch or empty if null
  }

  DateTime? dateOfBirth;

  void _selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateOfBirth ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDateOfBirth) {
      setState(() {
        selectedDateOfBirth = picked;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Set the initial date
      firstDate: DateTime(2000), // Set the start date
      lastDate: DateTime(2101), // Set the end date
    );
    if (picked != null) {
      setState(() {
        // Format the picked date as you want
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  TextEditingController batchController = TextEditingController();
  List<String> selectedWeekdays = []; // List to store selected weekdays
  List<String> selectedWeekends = [];
  bool isChecked = false;
  List<bool> checkboxValues = List.generate(8, (index) => false);

  @override
  Widget build(context) {
    // AddStudentProvider addStudentProvider =
    //     Provider.of<AddStudentProvider>(context, listen: false);
    // ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 6.0,
        shadowColor: Colors.black,
        centerTitle: true,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        title: const Text(
          'Add student',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
            child: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Screens.bodyheight(context) * 0.02),
            child: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: _pickImage, // Use the _pickImage function here
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _image != null
                      ? FileImage(File(_image!.path)) as ImageProvider
                      : const AssetImage(
                          'lib/assets/peopleplaceholder.png'), // Placeholder image
                  backgroundColor: Colors.grey[200], // Default background color
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: context.watch<BatchListProvider>().batchstudentformKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Batch name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        // labelText: 'Batch Name',
                        labelStyle: TextStyle(color: Colors.grey),
                        hintText: 'Batch name',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.batch_prediction_outlined,
                          color: Colors.blue,
                        ),
                      ),
                      value: context.read<BatchListProvider>().selectedBatch,
                      icon:
                          const Icon(Icons.arrow_drop_down, color: Colors.grey),
                      onChanged: (String? newValue) {
                        setState(() {
                          context.read<BatchListProvider>().selectedBatch =
                              newValue;
                          batchController.text = newValue ?? "";
                        });
                      },
                      items: context.read<BatchListProvider>().batches.map((e) {
                        return DropdownMenuItem<String>(
                          value: e.name,
                          child: Text(e.name),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: context
                          .watch<BatchListProvider>()
                          .batchstudentctrlr[0],
                      cursorColor: Colors.blue,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the student name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Student name',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          // borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          // borderRadius: BorderRadius.circular(5.5),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                        // hintText: "Enter your Name",
                        hintStyle: TextStyle(color: Colors.blue),
                        // filled: true,
                        // fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      cursorColor: Colors.blue,
                      controller: context
                          .read<BatchListProvider>()
                          .batchstudentctrlr[1],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter the name of mobile number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'mobile number',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          // borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon:
                            Icon(Icons.phone_android, color: Colors.blue),
                        // hintText: "Enter your Name",
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 15),
                    TextFormField(
                      cursorColor: Colors.blue,
                      controller: context
                          .watch<BatchListProvider>()
                          .batchstudentctrlr[2],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Father name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Father name',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                        // hintText: "Enter your Name",
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      cursorColor: Colors.blue,
                      controller: context
                          .watch<BatchListProvider>()
                          .batchstudentctrlr[3],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the father mobile number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Father mobile number',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          // borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          // borderRadius: BorderRadius.circular(5.5),
                        ),
                        prefixIcon:
                            Icon(Icons.phone_android, color: Colors.blue),
                        // hintText: "Enter your Name",
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      cursorColor: Colors.blue,
                      controller: context.watch()<BatchListProvider>()
                          .batchstudentctrlr[4],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Mother name ';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Mother name',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                        // hintText: "Enter your Name",
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      cursorColor: Colors.blue,
                      controller: context
                          .watch<BatchListProvider>()
                          .batchstudentctrlr[5],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Mother mobile';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Mother mobile number',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.phone_android, color: Colors.blue),
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      cursorColor: Colors.blue,
                      controller: context.watch<BatchListProvider>().batchstudentctrlr[7],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the date of Birth';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Date of Birth',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          final formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                          context.read<BatchListProvider>().batchstudentctrlr[7].text = formattedDate;
                        }
                      },
                      readOnly:
                          true, // Make the field read-only to prevent manual input
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      readOnly: true,
                      controller: _dateController,
                      cursorColor: Colors.blue,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                      onTap: () => _selectDate(context), // Show the date picker on tap
                      keyboardType: TextInputType.datetime,
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      cursorColor: Colors.blue,
                      controller: context.read<BatchListProvider>().batchstudentctrlr[6],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Fees amount';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Fees Amount',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: Icon(Icons.currency_rupee, color: Colors.blue),
                        hintStyle: TextStyle(color: Colors.blue),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    context.read<BatchListProvider>().batchaddstudentlist(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'save',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox formdategap(BuildContext context) =>
      SizedBox(width: Screens.width(context) * 0.001);
}
