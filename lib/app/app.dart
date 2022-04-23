import 'package:expense_tracker/define/enums/category_enum.dart';
import 'package:expense_tracker/home/screens/home_screen.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/theme/app_theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final String flavor;

  const App({Key? key, required this.flavor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Transaction> transactions = [
      Transaction(
          id: '1',
          type: 'income',
          name: 'Buy shoes',
          categoryId: CategoryEnum.food,
          amount: 100.0,
          note: null,
          createdAt: '2022-04-22 12:00:00'),
      Transaction(
          id: '2',
          name: 'Buy shirt',
          type: 'expense',
          categoryId: CategoryEnum.shopping,
          amount: 200.0,
          note: null,
          createdAt: '2022-04-22 12:00:00'),
      Transaction(
          id: '1',
          type: 'expense',
          name: 'Buy shoes',
          categoryId: CategoryEnum.transportation,
          amount: 100.0,
          note: null,
          createdAt: '2022-04-22 12:00:00'),
      Transaction(
          id: '2',
          name: 'Buy shirt',
          type: 'expense',
          categoryId: CategoryEnum.health,
          amount: 200.0,
          note: null,
          createdAt: '2022-04-22 12:00:00'),
      Transaction(
          id: '2',
          name: 'Buy shirt',
          type: 'expense',
          categoryId: CategoryEnum.beauty,
          amount: 200.0,
          note: null,
          createdAt: '2022-04-22 12:00:00'),
      Transaction(
          id: '1',
          type: 'income',
          name: 'Buy shoes',
          categoryId: CategoryEnum.entertainment,
          amount: 100.0,
          note: null,
          createdAt: '2022-04-22 12:00:00'),
      Transaction(
          id: '1',
          type: 'income',
          name: 'Buy shoes',
          categoryId: CategoryEnum.travel,
          amount: 100.0,
          note: null,
          createdAt: '2022-04-22 12:00:00'),
      Transaction(
          id: '1',
          type: 'income',
          name: 'Buy shoes',
          categoryId: CategoryEnum.other,
          amount: 100.0,
          note: null,
          createdAt: '2022-04-22 12:00:00'),
    ];
    return MaterialApp(
      title: 'Expanse Tracker',
      theme: AppTheme.light,
      home: HomeScreen(
        transactions: transactions,
      ),
    );
  }
}
