import 'dart:developer';
import 'dart:io';

import 'package:badmiton_app/constant/Screen.dart';
import 'package:badmiton_app/controller/dashstudentcontroller.dart/add_student_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddStudentForm1 extends StatefulWidget {
  const AddStudentForm1({super.key});

  @override
  _AddStudentForm1State createState() => _AddStudentForm1State();
}

class _AddStudentForm1State extends State<AddStudentForm1> {
  DateTime? selectedDateOfBirth;
  XFile? _image; // This will hold the image file
  final ImagePicker _picker = ImagePicker(); // Create an ImagePicker instance

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
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

  @override
  Widget build(BuildContext context) {
    final studentcurrentTime = TimeOfDay.now();
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
        title: Text(
          context.read<AddStudentProvider>().studentcondition == true
              ? 'Add Student'
              : 'Update Student',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          child: Form(
            key: context.watch<AddStudentProvider>().addstuentkey1,
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
                    backgroundColor:
                        Colors.blue[200], // Default background color
                  ),
                ),
                const SizedBox(height: 20),
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
                    // Remove border
                    border: UnderlineInputBorder(),
                    // filled: true,
                    // // fillColor: Colors.white,
                    // fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                  ),
                  value: context.read<AddStudentProvider>().selectedBatch,
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onChanged: (String? newValue) {
                    setState(() {
                      context.read<AddStudentProvider>().selectedBatch =
                          newValue;
                    });
                  },
                  items: context.watch<AddStudentProvider>().batchItem.map((e) {
                    log("selectedBatch ::${context.read<AddStudentProvider>().batchItem}");
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller:
                      context.read<AddStudentProvider>().studentcontroller[0],
                  cursorColor: Colors.blue,
                  // controller: context.read<BatchListProvider>().mycontroller[2],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Student name';
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
                  controller:
                      context.read<AddStudentProvider>().studentcontroller[1],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Mobile number';
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
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    prefixIcon: Icon(Icons.phone_android, color: Colors.blue),
                    // hintText: "Enter your Name",
                    hintStyle: TextStyle(color: Colors.blue),
                    // filled: true,
                    // fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                  ),
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 15),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller:
                      context.read<AddStudentProvider>().studentcontroller[2],
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
                  controller:
                      context.read<AddStudentProvider>().studentcontroller[3],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Father mobile';
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
                    prefixIcon: Icon(Icons.phone_android, color: Colors.blue),
                    // hintText: "Enter your Name",
                    hintStyle: TextStyle(color: Colors.blue),
                    // filled: true,
                    // fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller:
                      context.read<AddStudentProvider>().studentcontroller[4],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Mother name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Mother name',
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
                  controller:
                      context.read<AddStudentProvider>().studentcontroller[5],
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
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    prefixIcon: Icon(Icons.phone_android, color: Colors.blue),
                    // hintText: "Enter your Name",
                    hintStyle: TextStyle(color: Colors.blue),
                    // filled: true,
                    // fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller:
                      context.read<AddStudentProvider>().studentcontroller[7],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Date of Birth';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    prefixIcon: Icon(Icons.calendar_today, color: Colors.blue),
                    // hintText: "Enter your Name",
                    hintStyle: TextStyle(color: Colors.blue),
                    // filled: true,
                    // fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                  ),
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      // Format the selected date to display only the date part
                      final formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      // Update the controller with the formatted date
                      context
                          .read<AddStudentProvider>()
                          .studentcontroller[7]
                          .text = formattedDate;
                    }
                  },
                  readOnly:
                      true, // Make the field read-only to prevent manual input
                ),

                const SizedBox(height: 15),

                // TextFormField(
                //   cursorColor: Colors.blue,
                //   // controller: context.read<BatchListProvider>().mycontroller[2],
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the Date of Birth';
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //     labelText: 'Date of Birth',
                //     labelStyle: const TextStyle(color: Colors.grey),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(color: Colors.transparent),
                //       borderRadius: BorderRadius.circular(5.5),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(color: Colors.transparent),
                //       borderRadius: BorderRadius.circular(5.5),
                //     ),
                //     prefixIcon:
                //         const Icon(Icons.calendar_today, color: Colors.blue),
                //     // hintText: "Enter your Name",
                //     hintStyle: const TextStyle(color: Colors.blue),
                //     filled: true,
                //     fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                //   ),
                //   keyboardType:
                //       TextInputType.datetime, // Specify input type as datetime
                // ),
                // const SizedBox(height: 15),

                // TextFormField(
                //   controller: TextEditingController(
                //     text: DateTime.now().toString(),
                //   ),
                //   cursorColor: Colors.blue,
                //   decoration: InputDecoration(
                //     labelText: 'Current Time',
                //     labelStyle: const TextStyle(color: Colors.grey),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(color: Colors.transparent),
                //       borderRadius: BorderRadius.circular(5.5),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: const BorderSide(color: Colors.transparent),
                //       borderRadius: BorderRadius.circular(5.5),
                //     ),
                //     prefixIcon:
                //         const Icon(Icons.access_time, color: Colors.blue),
                //     hintStyle: const TextStyle(color: Colors.blue),
                //     filled: true,
                //     fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                //   ),
                //   keyboardType:
                //       TextInputType.datetime, // Specify input type as datetime
                // ),
                // const SizedBox(height: 15),

                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                      text:
                          '${studentcurrentTime.hour}.${studentcurrentTime.minute}'),
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                    // labelText: 'Current Time',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    prefixIcon: Icon(Icons.access_time, color: Colors.blue),
                    hintStyle: TextStyle(color: Colors.blue),
                    // filled: true,
                    // fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                  ),
                  keyboardType:
                      TextInputType.datetime, // Specify input type as datetime
                ),
                const SizedBox(height: 15),
                // const SizedBox(height: 15),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller:
                      context.read<AddStudentProvider>().studentcontroller[6],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Fees amount';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Fees amount',
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      // borderRadius: BorderRadius.circular(5.5),
                    ),
                    prefixIcon: Icon(Icons.currency_rupee, color: Colors.blue),
                    // hintText: "Enter your Name",
                    hintStyle: TextStyle(color: Colors.blue),
                    // filled: true,
                    // fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),

                //     Checkbox(
                //       value: checkboxValues[3],
                //       onChanged: (bool? newValue) {
                //         setState(() {
                //           checkboxValues[3] = newValue ?? false;
                //         });
                //       },
                //     ),
                //     SizedBox(
                //         width: Screens.width(context) *
                //             0.001), // Add spacing between checkbox and text
                //     const Text('Thu'),
                //     Formdategap(context),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Checkbox(
                //       value: checkboxValues[4],
                //       onChanged: (bool? newValue) {
                //         setState(() {
                //           checkboxValues[4] = newValue ?? false;
                //         });
                //       },
                //     ),
                //     SizedBox(
                //         width: Screens.width(context) *
                //             0.001), // Add spacing between checkbox and text
                //     const Text('Fri'),
                //     Checkbox(
                //       value: checkboxValues[5],
                //       onChanged: (bool? newValue) {
                //         setState(() {
                //           checkboxValues[5] = newValue ?? false;
                //         });
                //       },
                //     ),
                //     SizedBox(
                //         width: Screens.width(context) *
                //             0.001), // Add spacing between checkbox and text
                //     const Text('Sat'),
                //     Checkbox(
                //       value: checkboxValues[6],
                //       onChanged: (bool? newValue) {
                //         setState(() {
                //           checkboxValues[6] = newValue ?? false;
                //         });
                //       },
                //     ),
                //     SizedBox(
                //         width: Screens.width(context) *
                //             0.001), // Add spacing between checkbox and text
                //     const Text('Sun'),
                //   ],
                // ),
                // const SizedBox(height: 15),
                // ToggleButtons(
                //   borderRadius: BorderRadius.circular(8),
                //   isSelected: [weekdays, weekends],
                //   onPressed: (int index) {
                //     setState(() {
                //       if (index == 0) {
                //         // Handle weekdays selection logic
                //         weekdays = !weekdays;
                //         if (weekdays) {
                //           // If weekdays is selected, set all weekdays to true
                //           checkboxValues[0] = true; // Monday
                //           checkboxValues[1] = true;
                //           checkboxValues[2] = true;
                //           checkboxValues[3] = true;
                //           checkboxValues[4] = true;
                //         } else {
                //           // If weekdays is deselected, set all weekdays to false
                //           checkboxValues[0] = false; // Monday
                //           checkboxValues[1] = false;
                //           checkboxValues[2] = false;
                //           checkboxValues[3] = false;
                //           checkboxValues[4] = false;
                //         }
                //       } else {
                //         // Handle weekends selection logic
                //         weekends = !weekends;
                //         if (weekends) {
                //           // If weekends is selected, set Saturday and Sunday checkboxes to true
                //           checkboxValues[5] = true; // Saturday
                //           checkboxValues[6] = true; // Sunday
                //         } else {
                //           // If weekends is deselected, set Saturday and Sunday checkboxes to false
                //           checkboxValues[5] = false; // Saturday
                //           checkboxValues[6] = false; // Sunday
                //         }
                //       }
                //     });
                //   },
                //   children: const <Widget>[
                //     Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 16),
                //       child: Text('Weekdays'),
                //     ),
                //     Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 16),
                //       child: Text('Weekends'),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 15),
                // TextFormField(
                //   controller: feesController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the fees amount';
                //     }
                //     return null;
                //   },
                //   decoration: const InputDecoration(
                //     labelText: 'Fees',
                //     // Add bottom border only
                //     border: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey),
                //     ),
                //   ),
                //   keyboardType: TextInputType.number,
                // ),
                // const SizedBox(height: 15),
                // TextFormField(
                //   controller: phoneController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the phone number';
                //     }
                //     return null;
                //   },
                //   decoration: const InputDecoration(
                //     labelText: 'Phone Number',
                //     // Add bottom border only
                //     border: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey),
                //     ),
                //   ),
                //   keyboardType: TextInputType.phone,
                // ),
                // const SizedBox(height: 15),
                // TextFormField(
                //   controller: altPhoneController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the Alternate Number';
                //     }
                //     return null;
                //   },
                //   decoration: const InputDecoration(
                //     labelText: 'Alternate Number',
                //     // Add bottom border only
                //     border: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey),
                //     ),
                //   ),
                //   keyboardType: TextInputType.phone,
                // ),
                // const SizedBox(height: 15),

                // Row(
                //   children: [
                //     Expanded(
                //       child: TextFormField(
                //         controller:
                //             dateOfJoiningController, // Use the new controller here
                //         decoration: const InputDecoration(
                //           labelText: 'Date of Joining',
                //           // Add bottom border only
                //           border: UnderlineInputBorder(
                //             borderSide: BorderSide(color: Colors.grey),
                //           ),
                //         ),
                //         onTap:
                //             _pickDateOfJoining, // Use the picker function on tap
                //         readOnly: true, // Prevent manual editing
                //         validator: (value) {
                //           if (value == null || value.isEmpty) {
                //             return 'Please enter the Date of Joining';
                //           }
                //           return null;
                //         },
                //       ),
                //     ),
                //     const SizedBox(width: 10),
                //     Expanded(
                //       child: TextFormField(
                //         controller:
                //             dateOfBirthController, // Use the controller here
                //         decoration: const InputDecoration(
                //           labelText: 'Date of Birth',
                //           // Add bottom border only
                //           border: UnderlineInputBorder(
                //             borderSide: BorderSide(color: Colors.grey),
                //           ),
                //         ),
                //         onTap:
                //             _pickDateOfBirth, // Use the picker function on tap
                //         readOnly: true, // Prevent manual editing
                //         validator: (value) {
                //           if (value == null || value.isEmpty) {
                //             return 'Please enter the Date of Birth';
                //           }
                //           return null;
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 15),
                // TextFormField(
                //   controller: emailController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the Email';
                //     }
                //     return null;
                //   },
                //   decoration: const InputDecoration(
                //     labelText: 'Email',
                //     // Add bottom border only
                //     border: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey),
                //     ),
                //   ),
                //   keyboardType: TextInputType.emailAddress,
                // ),
                // const SizedBox(height: 15),
                // TextFormField(
                //   controller: notesController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the Notes';
                //     }
                //     return null;
                //   },
                //   decoration: const InputDecoration(
                //     labelText: 'Notes',
                //     // Add bottom border only
                //     border: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey),
                //     ),
                //   ),
                //   maxLines: 3,
                // ),
                const SizedBox(height: 20),
                // if (!_isLoading) // Only show the button if not loading
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      context
                          .read<AddStudentProvider>()
                          .toggleStudentCondition(context);
                    });

                    final message =
                        context.read<AddStudentProvider>().studentcondition
                            ? 'Saved successfully'
                            : 'updated successfully';

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    context.read<AddStudentProvider>().studentcondition
                        ? 'save'
                        : 'update',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox Formdategap(BuildContext context) =>
      SizedBox(width: Screens.width(context) * 0.001);
}
