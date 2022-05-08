import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:expense_tracker/blocs/transaction/index.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/theme/app_theme.dart';
import 'package:expense_tracker/widgets/add_transaction.dart';
import 'package:expense_tracker/widgets/amount_indicator.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  void _emitTransactionQueryParamsChangeEvent(
      DateTime selectedDate, BuildContext context) {
    final queryParams = TransactionQueryParams(
      createdAtFrom: firestore.Timestamp.fromDate(
          DateTime(selectedDate.year, selectedDate.month)),
      createdAtTo: firestore.Timestamp.fromDate(
          DateTime(selectedDate.year, selectedDate.month + 1)),
    );

    BlocProvider.of<TransactionBloc>(context)
        .add(ChangeTransactionQueryParamsEvent(queryParams: queryParams));
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );

    if (pickedDate != null) {
      _emitTransactionQueryParamsChangeEvent(pickedDate, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddTransaction(),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionInitialState) {
            _emitTransactionQueryParamsChangeEvent(DateTime.now(), context);
          }

          if (state is TransactionLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppTheme.accentColor),
            );
          }

          if (state is TransactionAddedState) {
            _emitTransactionQueryParamsChangeEvent(DateTime.now(), context);
          }

          if (state is TransactionLoadedState) {
            final incomeAmount =
                Transaction.getIncomeAmount(state.transactions);

            final expenseAmount =
                Transaction.getExpenseAmount(state.transactions);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.calendar,
                          color: AppTheme.accentColor,
                          size: 40.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        state.transactionMonth,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          AmountIndicator(
                            type: 'Income',
                            amount: incomeAmount,
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          AmountIndicator(
                            type: 'Expense',
                            amount: expenseAmount,
                            isMinus: expenseAmount > incomeAmount,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 25.0),
                  width: double.infinity,
                  color: AppTheme.lightColor,
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
                    color: AppTheme.lightColor,
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 50.0),
                    child: TransactionList(transactions: state.transactions),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Text(
              'Error!',
              style: TextStyle(color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
