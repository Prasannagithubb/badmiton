import 'package:badmiton_app/constant/Screen.dart';
import 'package:badmiton_app/controller/dashbatchconroller/batch_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBatch extends StatefulWidget {
  const AddBatch({super.key});

  @override
  State<AddBatch> createState() => _AddBatchState();
}

class _AddBatchState extends State<AddBatch> {
  @override
  void initState() {
    super.initState();
  }

  // void dispose() {
  //   batchListProvider.nameFocusNode.dispose();
  //   batchListProvider.descriptionFocusNode.dispose();
  //   batchListProvider.feesFocusNode.dispose();
  //   batchListProvider.studentIntakeFocusNode.dispose();
  //   super.dispose();
  // }

  // void addBatch(BuildContext context, Batchs batch) {
  //   final batchListProvider =
  //       Provider.of<BatchListProvider>(context, listen: false);
  //   batchListProvider.addBatch(batch);
  // }

  bool hasError = false;
  String? selectedTime;
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();

  void _showTimePicker(String type) async {
    TimeOfDay? selectedTimeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTimeOfDay != null) {
      String formattedTime = selectedTimeOfDay.format(context);
      setState(() {
        if (type == 'from') {
          fromTimeController.text = formattedTime;
        } else if (type == 'to') {
          toTimeController.text = formattedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // final formKey = GlobalKey<FormState>();
    // final batchListProvider = context.watch<BatchListProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Batch'),
        centerTitle: true,
        actions: const [
          // if (_formKey.currentState?.validate() ?? false)
          // IconButton(
          //   icon: const Icon(Icons.add),
          //   onPressed: () {
          //     // Add your action here
          //   },
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Form(
            key: context.read<BatchListProvider>().batchformKey,
            child: Column(
              children: [
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Text(
                //       'Batch name',
                //       style: Theme.of(context)
                //           .textTheme
                //           .labelMedium
                //           ?.copyWith(color: Colors.blue),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: hasError
                      ? Screens.bodyheight(context) * 0.1
                      : Screens.bodyheight(context) * 0.08,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        hasError = true;
                        return 'Please enter the Batch name';
                      }
                      hasError = false;
                      return null;
                    },
                    controller:
                        context.read<BatchListProvider>().mycontroller[0],
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      labelText: 'Batch Name',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.blue),
                    ),
                  ),
                ),

                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                SizedBox(
                  height: hasError
                      ? Screens.bodyheight(context) * 0.1
                      : Screens.bodyheight(context) * 0.1,
                  child: TextFormField(
                    cursorColor: Colors.blue,
                    controller:
                        context.read<BatchListProvider>().mycontroller[1],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the description';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      labelStyle: TextStyle(color: Colors.grey),
                      labelText: 'Description',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      prefixIcon: Icon(Icons.description, color: Colors.blue),
                      hintStyle: TextStyle(color: Colors.blue),
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Text(
                //       'Fees',
                //       style: Theme.of(context)
                //           .textTheme
                //           .labelMedium
                //           ?.copyWith(color: Colors.blue),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: hasError
                      ? Screens.bodyheight(context) * 0.1
                      : Screens.bodyheight(context) * 0.08,
                  child: TextFormField(
                    cursorColor: Colors.blue,
                    controller:
                        context.read<BatchListProvider>().mycontroller[2],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the fees amount';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      focusColor: Colors.blue,
                      labelText: 'Fees',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        // borderRadius: BorderRadius.circular(5.5),
                      ),
                      // ignore: prefer_const_constructors
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        // borderRadius: BorderRadius.circular(5.5),
                      ),
                      prefixIcon: Icon(Icons.currency_rupee_rounded,
                          color: Colors.blue),
                      hintStyle: TextStyle(color: Colors.blue),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),

                // TextFormField(
                //   controller: feesController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter the fees amount';
                //     }
                //     return null;
                //   },
                //   decoration: const InputDecoration(
                //     hintStyle: TextStyle(color: Colors.grey),
                //     // hintText: 'Enter the Fees',
                //     // labelText: 'Fees',
                //     border: UnderlineInputBorder(
                //       borderSide: BorderSide(color: Colors.grey),
                //     ),
                //   ),
                //   keyboardType: TextInputType.number,
                // ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                // const Divider(
                //   thickness: 0.4,
                // ),
                // Center(
                //     child: Text(
                //   'ADDTIONAL INFORMATION (OPTIONAL)',
                //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                //       fontWeight: FontWeight.bold, color: Colors.grey),
                // )),
                // SizedBox(
                //   height: Screens.bodyheight(context) * 0.01,
                // ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Text(
                    //   'Student intake',
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .labelMedium
                    //       ?.copyWith(color: Colors.blue),
                    // ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Text(
                //       'set a limit of max intake of student for the batch',
                //       style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //             color: Colors.grey.shade400,
                //           ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: hasError
                      ? Screens.bodyheight(context) * 0.1
                      : Screens.bodyheight(context) * 0.08,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the value';
                      }
                      return null;
                    },
                    cursorColor: Colors.blue,
                    controller:
                        context.watch<BatchListProvider>().mycontroller[3],
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text('Enter student intake'),
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
                          Icon(Icons.people_alt_rounded, color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Batch timings',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.blue),
                    ),
                  ],
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: fromTimeController,
                                  onTap: () {
                                    _showTimePicker('from');
                                  },
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue),
                                    ),
                                    suffixIcon: Icon(Icons.timer_sharp),
                                    labelText: 'From Time',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text('   -- '),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: toTimeController,
                                  onTap: () {
                                    _showTimePicker('to');
                                  },
                                  decoration: const InputDecoration(
                                    suffixIcon: Icon(Icons.timer_sharp),
                                    labelText: 'To Time',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Text(
                      'Selected time: ${fromTimeController.text} - ${toTimeController.text}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.002,
                ),
                Card(
                  color: Colors.white,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          // border: Border.all()
                          ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Batch days:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.blue,
                                    ),
                              ),
                            ],
                          ),
                          Text(
                            'you can take attaendance for the batch only on the selected days',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.blue,
                                value: context
                                    .read<BatchListProvider>()
                                    .checkboxValues[0],
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    context .read<BatchListProvider>() .checkboxValues[0] = newValue ?? false;
                                  });
                                },
                              ),
                              SizedBox(
                                  width: Screens.width(context) *
                                      0.0001), // Add spacing between checkbox and text
                              const Text('Mon'),
                              formdategap(context),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: context
                                    .read<BatchListProvider>()
                                    .checkboxValues[1],
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    context .read<BatchListProvider>().checkboxValues[1] = newValue ?? false;
                                  });
                                },
                              ),
                              SizedBox(
                                  width: Screens.width(context) *
                                      0.001), // Add spacing between checkbox and text
                              const Text('Tue'),
                              formdategap(context),

                              Checkbox(
                                activeColor: Colors.blue,
                                value: context
                                    .read<BatchListProvider>()
                                    .checkboxValues[2],
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    context.read<BatchListProvider>().checkboxValues[2] = newValue ?? false;
                                  });
                                },
                              ),
                              SizedBox(
                                  width: Screens.width(context) *
                                      0.001), // Add spacing between checkbox and text
                              const Text('wed'),
                              formdategap(context),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: context.read<BatchListProvider>().checkboxValues[3],
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    context
                                        .read<BatchListProvider>()
                                        .checkboxValues[3] = newValue ?? false;
                                  });
                                },
                              ),
                              SizedBox(
                                  width: Screens.width(context) * 0.001), // Add spacing between checkbox and text
                              const Text('Thu'),
                              formdategap(context),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                activeColor: Colors.blue,
                                value: context
                                    .read<BatchListProvider>()
                                    .checkboxValues[4],
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    context
                                        .read<BatchListProvider>()
                                        .checkboxValues[4] = newValue ?? false;
                                  });
                                },
                              ),
                              SizedBox(
                                  width: Screens.width(context) *
                                      0.001), // Add spacing between checkbox and text
                              const Text('Fri'),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: context
                                    .read<BatchListProvider>()
                                    .checkboxValues[5],
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    context
                                        .read<BatchListProvider>()
                                        .checkboxValues[5] = newValue ?? false;
                                  });
                                },
                              ),
                              SizedBox(
                                  width: Screens.width(context) * 0.001), // Add spacing between checkbox and text
                              const Text('Sat'),
                              Checkbox(
                                activeColor: Colors.blue,
                                value: context.read<BatchListProvider>().checkboxValues[6],
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    context.read<BatchListProvider>().checkboxValues[6] = newValue ?? false;
                                  });
                                },
                              ),
                              SizedBox(width: Screens.width(context) * 0.001), // Add spacing between checkbox and text
                              const Text('Sun'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),

                SizedBox(
                  height: Screens.bodyheight(context) * 0.01,
                ),
                SizedBox(
                  width: Screens.width(context),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade300), // Set background color
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Set text color
                      // You can add more styles as needed
                    ),
                    // style: ButtonStyle(foregroundColor: Colors.blue),
                    onPressed: () {
                      setState(() {
                        context.read<BatchListProvider>().addBatchList(context);
                      });
                    },
                    child: Text(
                      'ADD',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

SizedBox formdategap(BuildContext context) =>
    SizedBox(width: Screens.width(context) * 0.001);
