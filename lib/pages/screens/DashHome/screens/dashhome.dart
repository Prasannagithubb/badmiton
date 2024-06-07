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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 6.0,
        shadowColor: Colors.black,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text('Dashboard',
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
                          curve: Curves.fastEaseInToSlowEaseOut,
                          height: isTapped
                              ? isExpanded
                                  ? 60
                                  : 0
                              : isExpanded
                                  ? 225
                                  : 300,
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HomeCard(
                      name: 'Batches',
                      number: '3',
                    ),
                    HomeCard(
                      name: 'Students',
                      number: '30',
                    ),

                    HomeCard(
                      name: 'Coaches',
                      number: '2',
                    ),
                    HomeCard(
                      name: 'Benches',
                      number: '2',
                    ),

                    // Repeat the above Card for the remaining items
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String name;
  final String number;

  const HomeCard({super.key, required this.name, required this.number});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Screens.bodyheight(context) * 0.2,
      width: Screens.width(context) * 0.35,
      // decoration: const BoxDecoration(color: Colors.lightGreen),
      child: Card(
        color: const Color.fromARGB(255, 232, 246, 233),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Color.fromARGB(255, 76, 176, 80),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                number,
                style: const TextStyle(
                  color: Color.fromARGB(255, 76, 176, 80),
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
