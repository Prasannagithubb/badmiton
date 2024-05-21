import 'package:badmiton_app/constant/Screen.dart';
import 'package:flutter/material.dart';

import '../../../../Models/studentdata.dart';

class DashHome extends StatefulWidget {
  const DashHome({super.key});

  @override
  State<DashHome> createState() => _DashHomeState();
}

class _DashHomeState extends State<DashHome> {
  final List<StudentData> items = [
    StudentData(
        title: "Students", count: 1, newStudents: 0, period: "in last 30 days"),
    StudentData(
        title: "Students", count: 1, newStudents: 0, period: "in last 30 days"),
    // Add more items as needed
  ];
  bool isTapped = true;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      
      appBar: AppBar(
        elevation: 6.0,
        shadowColor: Colors.black,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Location - '),
                    Text(
                      'Delhi',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Switch Location'),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isTapped = !isTapped;
                        });
                      },
                      icon: Icon(
                        isTapped
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up,
                        color: Colors.black,
                        size: 27,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(0.8),
                child: SizedBox(
                  width: 400,
                  child: Column(
                    children: [
                      // const SizedBox(
                      //   height: 100,
                      // ),
                      InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            isTapped = !isTapped;
                          });
                        },
                        onHighlightChanged: (value) {
                          setState(() {
                            isExpanded = value;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: isTapped
                              ? isExpanded
                                  ? 60
                                  : 0
                              : isExpanded
                                  ? 225
                                  : 230,
                          width: isExpanded ? 385 : 390,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                // color: Colors.black,
                                blurRadius: 0.2,
                                // offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          child: isTapped
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Icon(
                                          isTapped
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          color: Colors.white,
                                          size: 27,
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                        'Have a multiple locations/centers to manage?'),
                                    SizedBox(
                                      height:
                                          Screens.bodyheight(context) * 0.02,
                                    ),
                                    SizedBox(
                                      height:
                                          Screens.bodyheight(context) * 0.050,
                                      width: Screens.width(context) * 0.32,
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: () {},
                                          child: const Row(
                                            children: [
                                              Icon(Icons.add),
                                              Text(
                                                ' ADD NEW',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      '(only owners can add location)',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: items
            //         .map((item) => Card(
            //               child: ListTile(
            //                 title: Text("${item.title}: ${item.count}"),
            //                 subtitle: Text(
            //                     "${item.newStudents} new students ${item.period}"),
            //                 leading: Icon(Icons.school),
            //                 trailing: Icon(Icons.arrow_forward),
            //               ),
            //             ))
            //         .toList(),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
