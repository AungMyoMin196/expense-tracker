import 'package:expense_tracker/blocs/transaction/index.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/theme/app_theme.dart';
import 'package:expense_tracker/widgets/amount_indicator.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TransactionBloc>(context).add(const LoadTransactionEvent());

    return Scaffold(
        backgroundColor: AppTheme.primaryColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppTheme.primaryColor,
          onPressed: () => debugPrint('test'),
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionInitialState ||
                state is TransactionLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: AppTheme.accentColor),
              );
            }

            if (state is TransactionLoadedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                        top: 70.0, left: 20.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          CupertinoIcons.calendar,
                          color: AppTheme.accentColor,
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
                          children: <Widget>[
                            AmountIndicator(
                                type: 'Income',
                                amount: Transaction.getIncomeAmount(
                                    state.transactions)),
                            const SizedBox(
                              width: 20.0,
                            ),
                            AmountIndicator(
                                type: 'Expense',
                                amount: Transaction.getExpenseAmount(
                                    state.transactions)),
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
        ));
  }
}
