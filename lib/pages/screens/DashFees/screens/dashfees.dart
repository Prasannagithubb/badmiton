import 'package:badmiton_app/constant/Screen.dart';
import 'package:badmiton_app/pages/screens/DashFees/widgets/pendingtabview.dart';
import 'package:flutter/material.dart';

import '../widgets/paidtabview.dart';

class DashBoardFees extends StatefulWidget {
  const DashBoardFees({super.key});

  @override
  State<DashBoardFees> createState() => _DashBoardFeesState();
}

class _DashBoardFeesState extends State<DashBoardFees>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    print('TabController initialized');
  }

  @override
  void dispose() {
    print('Disposing TabController');
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Building Widget');
    if (_tabController == null) {
      print('TabController is null when building widget');
      return Container(); // Return an empty container to avoid errors.
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 6.0,
        shadowColor: Colors.black,
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text('Fees', style: TextStyle(color: Colors.white)),
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
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(8.0),
            height: Screens.bodyheight(context) * 0.06,
            width: Screens.width(context) * 0.6,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.5), // Adjust the opacity as needed
                  spreadRadius: 1, // Spread radius
                  blurRadius: 6, // Blur radius
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ), // Optional: adds a background color to the TabBar container
            child: TabBar(
              controller: _tabController!,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.all(1.0),
              tabs: const [
                Tab(text: 'Pending'),
                Tab(text: 'Paid'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController!,
              children: const [
                TabviewPending(),
                PaidTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
