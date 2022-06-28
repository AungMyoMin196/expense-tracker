import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/abstracts/to_firebase.dart';
import 'package:expense_tracker/defines/enums/category_enum.dart';
import 'package:expense_tracker/defines/enums/transaction_type_enum.dart';
import 'package:intl/intl.dart';

class Transaction extends Equatable implements ToFirebase {
  final String? id;
  final String uid;
  final TransactionTypeEnum typeId;
  final String name;
  final CategoryEnum categoryId;
  final num amount;
  final String? note;
  final Timestamp date;
  final Timestamp createdAt;

  const Transaction(
      {this.id,
      required this.uid,
      required this.typeId,
      required this.name,
      required this.categoryId,
      required this.amount,
      required this.date,
      this.note,
      required this.createdAt});

  bool isExpense() {
    return typeId == TransactionTypeEnum.expense;
  }

  String getDisplayAmount() {
    return isExpense()
        ? '-¥${amount.toStringAsFixed(0)}'
        : '+¥${amount.toStringAsFixed(0)}';
  }

  String getDisplayDate() {
    return DateFormat.MMMd().format(date.toDate());
  }

  String getTransactionTypeName() {
    return isExpense() ? 'expense' : 'income';
  }

  factory Transaction.fromFirebase(Map<String, dynamic> doc) => Transaction(
        id: doc['id'],
        uid: doc['uid'],
        typeId: TransactionTypeEnum.values[doc['typeId'] - 1],
        name: doc['name'],
        categoryId: CategoryEnum.values[doc['categoryId'] - 1],
        amount: doc['amount'],
        date: doc['date'],
        note: doc['note'],
        createdAt: doc['createdAt'],
      );

  @override
  Map<String, dynamic> toFirebase() => {
        'uid': uid,
        'typeId': typeId.index + 1,
        'name': name,
        'categoryId': categoryId.index + 1,
        'amount': amount,
        'date': date,
        'note': note,
        'createdAt': createdAt,
      };

  static num getExpenseAmount(List<Transaction> transactions) {
    List<Transaction> expenseTransactions = transactions
        .where((Transaction transaction) => transaction.isExpense())
        .toList();

    if (expenseTransactions.isEmpty) {
      return 0;
    }

    return expenseTransactions
        .map((Transaction transaction) => transaction.amount)
        .reduce((acc, cur) => acc + cur);
  }

  static num getIncomeAmount(List<Transaction> transactions) {
    List<Transaction> incomeTransactions = transactions
        .where((Transaction transaction) => !transaction.isExpense())
        .toList();

    if (incomeTransactions.isEmpty) {
      return 0;
    }

    return incomeTransactions
        .map((Transaction transaction) => transaction.amount)
        .reduce((acc, cur) => acc + cur);
  }

  static List<Transaction> getExpenseTransactions(
      List<Transaction> transactions) {
    return transactions
        .where((Transaction transaction) => transaction.isExpense())
        .toList();
  }

  static double getAmountRateByCategory(List<Transaction> expenseTransactions,
      num expenseAmount, CategoryEnum categoryId) {
    List<Transaction> expenseTransactionsByCategory = expenseTransactions
        .where(
            (Transaction transaction) => transaction.categoryId == categoryId)
        .toList();

    if (expenseTransactionsByCategory.isEmpty) {
      return 0;
    }

    num expenseAmountByCategory = expenseTransactionsByCategory
        .map((Transaction transaction) => transaction.amount)
        .reduce((acc, cur) => acc + cur);
    return (expenseAmountByCategory * 100) / expenseAmount;
  }

  static String getEstimateSavingDisplayText(
      DateTime selectedDate, num savingAmount) {
    String _savingAmount = savingAmount.toStringAsFixed(0);
    return selectedDate.isAfter(DateTime.now()) ||
            (DateFormat('yyyy-MM').format(selectedDate) ==
                DateFormat('yyyy-MM').format(DateTime.now()))
        ? 'Estimate savings...    ¥ $_savingAmount'
        : 'Saved...    ¥ $_savingAmount';
  }

  @override
  List<Object?> get props => [id, typeId, name, categoryId, amount, createdAt];
}

class TransactionQueryParams extends Equatable {
  final String? uid;
  final Timestamp? dateFrom;
  final Timestamp? dateTo;

  const TransactionQueryParams({this.dateFrom, this.dateTo, this.uid});

  @override
  List<Object?> get props => [uid, dateFrom, dateTo];
}
