import 'dart:io';

import 'package:badmiton_app/controller/dashaddcoach.dart/dash_coach_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCouch extends StatefulWidget {
  const AddCouch({super.key});

  @override
  _AddCouchState createState() => _AddCouchState();
}

class _AddCouchState extends State<AddCouch> {
  DateTime? dateOfJoining;
  DateTime? dateOfResignation;

  XFile? _image; // This will hold the profile image file
  XFile? _idCardImage; // This will hold the ID card image file
  XFile? _bankPassbookImage; // This will hold the bank passbook image file
  final ImagePicker _picker = ImagePicker(); // Create an ImagePicker instance

  String? _idCardError;
  String? _bankPassbookError;

  // Function to handle image picking
  Future<void> _pickImage(
      XFile? imageFile, ValueChanged<XFile?> onImageSelected) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          onImageSelected(pickedFile);
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

  Future<void> _selectDate(BuildContext context, DateTime? selectedDate,
      ValueChanged<DateTime?> onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
    }
  }

  InputDecoration getInputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5.5),
      ),
      prefixIcon: Icon(icon, color: Colors.blue),
      hintStyle: const TextStyle(color: Colors.blue),
      filled: true,
      fillColor: Colors.lightBlue.shade50.withOpacity(0.4),
    );
  }

  @override
  Widget build(BuildContext context) {
    // DashCoachProvider dashCoachProvider = Provider.of<DashCoachProvider>(context);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const Text('Add Coach'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => _pickImage(_image, (image) => _image = image),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: _image != null
                      ? FileImage(File(_image!.path)) as ImageProvider
                      : const AssetImage('lib/assets/peopleplaceholder.png'),
                  backgroundColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: context.watch<DashCoachProvider>().coachformKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller:
                          context.watch<DashCoachProvider>().coachcontroller[0],
                      cursorColor: Colors.blue,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      decoration: getInputDecoration('Name', Icons.person),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller:
                          context.watch<DashCoachProvider>().coachcontroller[1],
                      cursorColor: Colors.blue,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a mobile number';
                        }
                        return null;
                      },
                      decoration: getInputDecoration('Mobile', Icons.phone),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _pickImage(_idCardImage, (image) {
                          _idCardImage = image;
                          _idCardError = null;
                        }),
                        child: const Text(
                          'Upload ID Card',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    if (_idCardError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _idCardError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    _idCardImage != null
                        ? Column(
                            children: [
                              const SizedBox(height: 16),
                              Image.file(
                                File(_idCardImage!.path),
                                height: 100,
                                width: 100,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller:
                          context.watch<DashCoachProvider>().coachcontroller[2],
                      cursorColor: Colors.blue,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the salary';
                        }
                        return null;
                      },
                      decoration: getInputDecoration('Salary', Icons.money),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller:
                          context.watch<DashCoachProvider>().coachcontroller[3],
                      cursorColor: Colors.blue,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter bank details';
                        }
                        return null;
                      },
                      decoration: getInputDecoration(
                          'Bank Details', Icons.account_balance),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            _pickImage(_bankPassbookImage, (image) {
                          _bankPassbookImage = image;
                          _bankPassbookError = null;
                        }),
                        child: const Text(
                          'Upload Bank Passbook',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    if (_bankPassbookError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _bankPassbookError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    _bankPassbookImage != null
                        ? Column(
                            children: [
                              const SizedBox(height: 16),
                              Image.file(
                                File(_bankPassbookImage!.path),
                                height: 100,
                                width: 100,
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _selectDate(context, dateOfJoining, (date) {
                        setState(() {
                          dateOfJoining = date;
                          context
                                  .read<DashCoachProvider>()
                                  .coachcontroller[4]
                                  .text =
                              date != null
                                  ? '${date.year}-${date.month}-${date.day}'
                                  : '';
                        });
                      }),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: context
                              .watch<DashCoachProvider>()
                              .coachcontroller[4],
                          cursorColor: Colors.blue,
                          decoration: getInputDecoration(
                              'Date of Joining', Icons.calendar_today),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the date of joining';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () =>
                          _selectDate(context, dateOfResignation, (date) {
                        setState(() {
                          dateOfResignation = date;
                          context
                                  .read<DashCoachProvider>()
                                  .coachcontroller[5]
                                  .text =
                              date != null
                                  ? '${date.year}-${date.month}-${date.day}'
                                  : '';
                        });
                      }),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: context
                              .watch<DashCoachProvider>()
                              .coachcontroller[5],
                          cursorColor: Colors.blue,
                          decoration: getInputDecoration(
                              'Date of Resignation', Icons.calendar_today),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the date of resignation';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double
                          .infinity, // Set the button to have maximum width
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _idCardError = _idCardImage == null
                                ? 'Please upload an ID card'
                                : null;
                            _bankPassbookError = _bankPassbookImage == null
                                ? 'Please upload a bank passbook'
                                : null;
                          });
                          if (context.read<DashCoachProvider>().validateForm(
                                isIdCardSelected: _idCardImage != null,
                                isBankPassbookSelected:
                                    _bankPassbookImage != null,
                              )) {
                            setState(() {
                              context.read<DashCoachProvider>().couchupdate(
                                  context,
                                  _idCardImage!.path,
                                  _bankPassbookImage!.path);
                            });
                            // context.read<DashCoachProvider>().saveForm(
                            //       idCardPath: _idCardImage?.path ?? '',
                            //       bankPassbookPath:
                            //           _bankPassbookImage?.path ?? '',
                            //     );
                            Get.back();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              color:
                                  Colors.green), // Change text color to green
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
