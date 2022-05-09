import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/define/enums/category_enum.dart';
import 'package:expense_tracker/define/enums/transaction_type_enum.dart';
import 'package:expense_tracker/services/abstracts/firestore_abstract.dart';
import 'package:intl/intl.dart';

class Transaction extends Equatable implements ToFirebase {
  final String? id;
  final TransactionTypeEnum typeId;
  final String name;
  final CategoryEnum categoryId;
  final num amount;
  final String? note;
  final Timestamp createdAt;

  const Transaction(
      {this.id,
      required this.typeId,
      required this.name,
      required this.categoryId,
      required this.amount,
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

  String getDisplayCreatedAt() {
    return DateFormat.MMMd().add_Hm().format(createdAt.toDate());
  }

  String getTransactionTypeName() {
    return isExpense() ? 'expense' : 'income';
  }

  factory Transaction.fromFirebase(Map<String, dynamic> doc) => Transaction(
        id: doc['id'],
        typeId: TransactionTypeEnum.values[doc['typeId'] - 1],
        name: doc['name'],
        categoryId: CategoryEnum.values[doc['categoryId'] - 1],
        amount: doc['amount'],
        note: doc['note'],
        createdAt: doc['createdAt'],
      );

  @override
  Map<String, dynamic> toFirebase() => {
        'typeId': typeId.index + 1,
        'name': name,
        'categoryId': categoryId.index + 1,
        'amount': amount,
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
        .reduce((value, element) => value + element);
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
        .reduce((value, element) => value + element);
  }

  @override
  List<Object?> get props => [id, typeId, name, categoryId, amount, createdAt];
}

class TransactionQueryParams extends Equatable {
  final Timestamp? createdAtFrom;
  final Timestamp? createdAtTo;

  const TransactionQueryParams({this.createdAtFrom, this.createdAtTo});

  @override
  List<Object?> get props => [createdAtFrom, createdAtTo];
}
