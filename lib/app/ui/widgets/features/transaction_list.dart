import 'package:expense_tracker/app/blocs/transaction/index.dart';
import 'package:expense_tracker/app/ui/widgets/features/transaction_list_tile.dart';
import 'package:expense_tracker/data/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        // return TransactionListTile(transaction: transactions[index]);
        final transaction = transactions[index];
        return Dismissible(
          // Each Dismissible must contain a Key. Keys allow Flutter to
          // uniquely identify widgets.
          key: Key(transaction.id!),
          // Provide a function that tells the app
          // what to do after an item has been swiped away.
          direction: DismissDirection.endToStart,

          onDismissed: (direction) {
            // Remove the item from the data source.
            BlocProvider.of<TransactionBloc>(context)
                .add(RemoveTransactionEvent(transaction: transaction));
            // Then show a snackbar.
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transaction has been deleted')));
          },
          // Show a red background as the item is swiped away.
          background: Container(
              color: Colors.red,
              margin: const EdgeInsets.only(bottom: 12.0),
              child: const Center(
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              )),
          child: TransactionListTile(transaction: transaction),
        );
      },
      itemCount: transactions.length,
    );
  }
}
