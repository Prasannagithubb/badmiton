import 'package:flutter/material.dart';

import '../../../../constant/Screen.dart';

class TabviewPending extends StatefulWidget {
  const TabviewPending({super.key});

  @override
  State<TabviewPending> createState() => _TabviewPendingState();
}

class _TabviewPendingState extends State<TabviewPending>
    with SingleTickerProviderStateMixin {
  bool isSwitched = true;
  TabController? _pendingTabController;

  @override
  void initState() {
    super.initState();
    _pendingTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _pendingTabController?.dispose();
    super.dispose();
  }

  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Screens.bodyheight(context) * 0.020),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Search pending list',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: Screens.bodyheight(context) * 0.020),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1 STUDENT PENDING',
                  style: theme.textTheme.titleMedium,
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  activeTrackColor: Colors.red.shade400,
                ),
              ],
            ),
            SizedBox(
              height: Screens.bodyheight(context) * 0.08,
              width: Screens.width(context) * 0.9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ToggleButtons(
                  isSelected: isSelected,
                  onPressed: (int index) {
                    setState(() {
                      showModalBottomSheet(
                          isDismissible: false,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          )),
                          context: context,
                          builder: ((context) {
                            return SizedBox(
                              width: Screens.width(context),
                              height: 200,
                              child: const Center(child: Text('Sort tab')),
                            );
                          }));
                      for (int buttonIndex = 0;
                          buttonIndex < isSelected.length;
                          buttonIndex++) {
                        isSelected[buttonIndex] = (buttonIndex == index);
                      }
                    });
                  },
                  borderColor: Colors.black,
                  selectedBorderColor: Colors.grey,
                  fillColor: Colors.grey.shade200,
                  selectedColor: Colors.grey,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.sort),
                          SizedBox(width: 5),
                          Text('Sort'),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isDismissible: false,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            )),
                            context: context,
                            builder: ((context) {
                              return SizedBox(
                                width: Screens.width(context),
                                height: 200,
                                child:
                                    const Center(child: Text(' Filterd List')),
                              );
                            }));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.filter),
                            SizedBox(width: 5),
                            Text('Filter'),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            isDismissible: false,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            )),
                            context: context,
                            builder: ((context) {
                              return SizedBox(
                                width: Screens.width(context),
                                height: 200,
                                child: const Center(
                                    child: Text('Downloaded List')),
                              );
                            }));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.download),
                            SizedBox(width: 5),
                            Text('Download'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /////////sample students///////////
            Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.person,
                      size: 50, color: theme.primaryColor), // Fixed size item
                  Expanded(
                    // This will allow the middle content to take available space
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to start
                        children: [
                          Text(
                            'Sample Students',
                            style: theme.textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                            overflow:
                                TextOverflow.ellipsis, // Prevent text overflow
                          ),
                          Text(
                            'No Fee History',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(color: Colors.grey),
                            overflow:
                                TextOverflow.ellipsis, // Prevent text overflow
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('Mark Paid'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('Remind Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
