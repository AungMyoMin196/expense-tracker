import 'package:expense_tracker/app/blocs/transaction/index.dart';
import 'package:expense_tracker/app/ui/widgets/features/amount_indicator.dart';
import 'package:expense_tracker/data/models/category_info.dart';
import 'package:expense_tracker/data/models/transaction.dart';
import 'package:expense_tracker/defines/enums/category_enum.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class FlipCardView extends StatefulWidget {
  const FlipCardView({
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  final DateTime selectedDate;
  @override
  State<FlipCardView> createState() => _FlipCardViewState();
}

class _FlipCardViewState extends State<FlipCardView> {
  final flipCardFrontHeight = 130.0;
  final flipCardBackHeight = 250.0;
  double flipCardHeight = 0;
  bool flipDone = false;

  @override
  void initState() {
    super.initState();
    flipCardHeight = flipCardFrontHeight;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
        buildWhen: (previous, current) {
      return current is TransactionLoadedState;
    }, builder: (context, state) {
      if (state is TransactionLoadedState) {
        final expenseTransactions =
            Transaction.getExpenseTransactions(state.transactions);
        final expenseAmount = Transaction.getExpenseAmount(state.transactions);
        final incomeAmount = Transaction.getIncomeAmount(state.transactions);
        final pileChartData = CategoryEnum.values.map((categoryId) {
          CategoryInfo category = CategoryInfo.getCategoryInfo(categoryId);
          final value = Transaction.getAmountRateByCategory(
              expenseTransactions, expenseAmount, categoryId);
          return PieChartSectionData(
              value: Transaction.getAmountRateByCategory(
                  expenseTransactions, expenseAmount, categoryId),
              color: category.color,
              title: value.toStringAsFixed(1) + '%',
              titleStyle: const TextStyle(
                fontSize: 12.0,
              ),
              badgeWidget: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 18,
                child: Icon(
                  category.icon,
                  size: 18.0,
                  color: category.color,
                ),
              ),
              badgePositionPercentageOffset: 0.95,
              radius: 100.0);
        }).toList();

        return SizedBox(
          height: flipCardHeight,
          child: FlipCard(
            fill: Fill.fillBack,
            direction: FlipDirection.VERTICAL,
            onFlipDone: (status) {
              setState(() {
                flipDone = status;
                flipCardHeight =
                    status ? flipCardBackHeight : flipCardFrontHeight;
              });
            },
            front: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  DateFormat.MMMM().format(widget.selectedDate),
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
            back: Visibility(
              visible: flipDone,
              child: expenseTransactions.isNotEmpty
                  ? PieChart(
                      PieChartData(
                        sections: pileChartData,
                      ),
                      swapAnimationDuration:
                          const Duration(milliseconds: 250), // Optional
                      swapAnimationCurve: Curves.linear, // Optional
                    )
                  : const Center(
                      child: Text('No data to display'),
                    ),
            ),
          ),
        );
      }

      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
