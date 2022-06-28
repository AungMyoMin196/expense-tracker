import 'dart:io';

import 'package:expense_tracker/app/ui/screens/modals/add_transaction_modal.dart';
import 'package:expense_tracker/app/ui/screens/pages/home_page.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int selectedPage = 0;

  final _pageList = const [
    HomePage(),
    // AnalyticsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // For future release
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.pie_chart),
      //       label: 'Analytics',
      //     ),
      //   ],
      //   currentIndex: selectedPage,
      //   onTap: (int index) {
      //     setState(() {
      //       selectedPage = index;
      //     });
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Platform.isIOS
                    ? const Radius.circular(30)
                    : const Radius.circular(10),
              ),
            ),
            builder: (_) => const AddTransactionModal(),
          );
        },
        child: const Icon(Icons.add),
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterDocked,
      body: _pageList[selectedPage],
    );
  }
}
