import 'package:expense_tracker/app/ui/widgets/features/transaction_list_tile.dart';
import 'package:expense_tracker/data/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return TransactionListTile(transaction: transactions[index]);
      },
      itemCount: transactions.length,
    );
  }
}
