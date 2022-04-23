import 'package:expense_tracker/home/widgets/amount_indicator.dart';
import 'package:expense_tracker/home/widgets/transaction_list.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.transactions}) : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: () => debugPrint('test'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  CupertinoIcons.calendar,
                  color: Color(0xFF222831),
                  size: 40.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'October',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: const <Widget>[
                    AmountIndicator(type: 'Income', amount: 336000),
                    SizedBox(
                      width: 20.0,
                    ),
                    AmountIndicator(type: 'Expense', amount: 336000),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
            width: double.infinity,
            color: const Color(0xFFEEEEEE),
            child: const Text(
              'Transactions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFEEEEEE),
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 50.0),
              child: TransactionList(transactions: transactions),
            ),
          ),
        ],
      ),
    );
  }
}
