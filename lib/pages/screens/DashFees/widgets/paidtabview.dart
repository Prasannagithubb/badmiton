import 'package:flutter/material.dart';

class PaidTabView extends StatefulWidget {
  const PaidTabView({super.key});

  @override
  State<PaidTabView> createState() => _PaidTabViewState();
}

class _PaidTabViewState extends State<PaidTabView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0 STUDENTS PAID',
                  style: theme.textTheme.bodyLarge,
                ),
                GestureDetector(
                  onTap: () {
                    print('Sort button pressed');
                  },
                  child: Row(
                    children: [
                      const Text('Sort'),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.sort)),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
