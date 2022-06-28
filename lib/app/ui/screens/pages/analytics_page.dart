import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:expense_tracker/app/blocs/auth/index.dart';
import 'package:expense_tracker/app/blocs/transaction/index.dart';
import 'package:expense_tracker/app/services/auth_service.dart';
import 'package:expense_tracker/app/ui/screens/pages/login_page.dart';
import 'package:expense_tracker/app/ui/widgets/features/unknown_error.dart';
import 'package:expense_tracker/data/models/category_info.dart';
import 'package:expense_tracker/data/models/transaction.dart';
import 'package:expense_tracker/defines/enums/category_enum.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

/// For future release
class AnalyticsPage extends StatefulWidget {
  static const String routePath = '/analytics';

  const AnalyticsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AnalyticsPage> createState() => _AnalyticsPage();
}

class _AnalyticsPage extends State<AnalyticsPage> {
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
          final expenseTransactions =
              Transaction.getExpenseTransactions(state.transactions);
          final expenseAmount =
              Transaction.getExpenseAmount(state.transactions);

          final sectionData = CategoryEnum.values.map((categoryId) {
            CategoryInfo category = CategoryInfo.getCategoryInfo(categoryId);
            final value = Transaction.getAmountRateByCategory(
                expenseTransactions, expenseAmount, categoryId);
            return PieChartSectionData(
                value: Transaction.getAmountRateByCategory(
                    expenseTransactions, expenseAmount, categoryId),
                color: category.color,
                title: value.toStringAsFixed(1) + '%',
                badgeWidget: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 18,
                  child: Icon(
                    category.icon,
                    size: 18.0,
                    color: category.color,
                  ),
                ),
                badgePositionPercentageOffset: 0.9,
                radius: 100.0);
          }).toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // color: AppTheme.accentColor,
                padding:
                    const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: _selectDate,
                          icon: const Icon(
                            Icons.calendar_month_outlined,
                            size: 40.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context)
                                .add(const SignOutEvent());
                            Navigator.pushReplacementNamed(
                                context, LoginPage.routePath);
                          },
                          icon: const Icon(
                            Icons.exit_to_app,
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      DateFormat.MMMM().format(selectedDate),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 180,
                      child: PieChart(
                        PieChartData(
                          sections: sectionData,
                        ),
                        swapAnimationDuration:
                            const Duration(milliseconds: 300), // Optional
                        swapAnimationCurve: Curves.linear, // Optional
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: 20.0, vertical: 20.0),
              //   width: double.infinity,
              //   color: AppTheme.lightColor,
              //   child: const Text(
              //     'Categories',
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: Container(
              //     color: AppTheme.lightColor,
              //     padding: const EdgeInsets.only(
              //         left: 20.0, right: 20.0, bottom: 50.0),
              //     child: TransactionList(transactions: state.transactions),
              //   ),
              // ),
            ],
          );
        }
        return const UnknownError();
      },
    );
  }
}
