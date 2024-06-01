import 'package:flutter/material.dart';

class FeesScreen extends StatefulWidget {
  const FeesScreen({super.key});

  @override
  _FeesScreenState createState() => _FeesScreenState();
}

class _FeesScreenState extends State<FeesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Fees',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade800,
      ),
      body: Column(
        children: [
          TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            controller: _tabController,
            tabs: const [
              Tab(text: 'Fees'),
              Tab(text: 'Others'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                FeesTab(),
                OthersTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class FeesTab extends StatefulWidget {
  const FeesTab({super.key});

  @override
  _FeesTabState createState() => _FeesTabState();
}

class _FeesTabState extends State<FeesTab> {
  bool isPaid = false;
  String? selectedMonth;
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.2),
                  //     blurRadius: 10,
                  //     spreadRadius: 5,
                  //   ),
                  // ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      curve: Curves.bounceIn,
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Amount Received!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 290,
            width: double.infinity,
            child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    // Enhancing shadow for 3D effect
                  ],
                ),
                child: Card(
                  color: Colors.green.shade100.withOpacity(0.9),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text(
                                'Select Month',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                              value: selectedMonth,
                              icon: Icon(Icons.arrow_drop_down,
                                  color: Colors.green.shade800),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedMonth = newValue!;
                                });
                              },
                              items: months.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 1.0,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Amount: 3000',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: selectedMonth != null
                              ? () {
                                  setState(() {
                                    isPaid = true;
                                  });
                                  _showPaymentDialog();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'Pay',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: isPaid
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 40,
                                  key: ValueKey('paid'),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

class OthersTab extends StatefulWidget {
  const OthersTab({super.key});

  @override
  _OthersTabState createState() => _OthersTabState();
}

class _OthersTabState extends State<OthersTab> {
  final TextEditingController _amountController = TextEditingController();
  bool isPaid = false;

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.bounceIn,
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 100,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Amount Received!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          elevation: 4.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: ' Amount',
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    focusColor: Colors.green,
                    labelText: ' Remarks',
                    border: UnderlineInputBorder(),
                  ),
                  maxLines: 1,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isPaid = true;
                  });
                  _showPaymentDialog();
                },
                child: const Text('Save'),
              ),
              const SizedBox(height: 20),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isPaid
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 40,
                        key: ValueKey('paid'),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
