import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:expense_tracker/app/blocs/auth/index.dart';
import 'package:expense_tracker/app/blocs/transaction/index.dart';
import 'package:expense_tracker/app/services/auth_service.dart';
import 'package:expense_tracker/app/ui/screens/pages/login_page.dart';
import 'package:expense_tracker/app/ui/widgets/features/flip_card_view.dart';
import 'package:expense_tracker/app/ui/widgets/features/unknown_error.dart';
import 'package:expense_tracker/app/ui/widgets/features/transaction_list.dart';
import 'package:expense_tracker/data/models/transaction.dart';
import 'package:expense_tracker/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class HomePage extends StatefulWidget {
  static const String routePath = '/home';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();

  void _emitTransactionQueryParamsChangeEvent() {
    final queryParams = TransactionQueryParams(
      uid: AuthService.instance.user!.uid,
      dateFrom: firestore.Timestamp.fromDate(
          DateTime(selectedDate.year, selectedDate.month)),
      dateTo: firestore.Timestamp.fromDate(DateTime(
        selectedDate.year,
        selectedDate.month + 1,
      )),
    );
    context
        .read<TransactionBloc>()
        .add(ChangeTransactionQueryParamsEvent(queryParams: queryParams));
  }

  void _selectDate() async {
    final DateTime? pickedDate = await showMonthPicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
      _emitTransactionQueryParamsChangeEvent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionAddedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('New transaction has been added'),
            ),
          );
          _emitTransactionQueryParamsChangeEvent();
        }
        if (state is TransactionRemovedState) {
          // Then show a snackbar.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Transaction has been deleted'),
            ),
          );
          _emitTransactionQueryParamsChangeEvent();
        }
        if (state is TransactionLoadingState) {
          // do nothing
        }
      },
      buildWhen: (previous, current) {
        return current is TransactionLoadedState;
      },
      builder: (context, state) {
        if (state is TransactionInitialState) {
          _emitTransactionQueryParamsChangeEvent();
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is TransactionLoadedState) {
          final incomeAmount = Transaction.getIncomeAmount(state.transactions);
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppTheme.accentColor,
                          child: IconButton(
                            onPressed: _selectDate,
                            icon: const Icon(
                              Icons.calendar_month_outlined,
                              size: 25.0,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: AppTheme.accentColor,
                          child: IconButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(const SignOutEvent());
                              Navigator.pushReplacementNamed(
                                  context, LoginPage.routePath);
                            },
                            icon: const Icon(
                              Icons.exit_to_app_outlined,
                              color: AppTheme.primaryColor,
                              size: 25.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    FlipCardView(
                      selectedDate: selectedDate,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0),
                color: AppTheme.accentColor.withOpacity(0.5),
                child: ListTile(
                  title: Text(
                    Transaction.getEstimateSavingDisplayText(
                        selectedDate, incomeAmount - expenseAmount),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
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
        return const UnknownError();
      },
    );
  }
}
