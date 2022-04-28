import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/define/enums/category_enum.dart';
import 'package:expense_tracker/models/category_info.dart';
import 'package:expense_tracker/services/abstracts/firestore_abstract.dart';
import 'package:expense_tracker/theme/category_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction extends Equatable implements FirestoreDocAbstract {
  final String id;
  final String type;
  final String name;
  final CategoryEnum categoryId;
  final num amount;
  final String? note;
  final Timestamp createdAt;

  const Transaction(
      {required this.id,
      required this.type,
      required this.name,
      required this.categoryId,
      required this.amount,
      this.note,
      required this.createdAt});

  CategoryInfo getCategoryInfo() {
    switch (categoryId) {
      case CategoryEnum.food:
        return CategoryInfo(
            name: 'Food', icon: Icons.lunch_dining, color: CategoryColor.food);
      case CategoryEnum.shopping:
        return CategoryInfo(
            name: 'Shopping',
            icon: Icons.shopping_bag,
            color: CategoryColor.shopping);
      case CategoryEnum.transportation:
        return CategoryInfo(
            name: 'Transportation',
            icon: Icons.commute,
            color: CategoryColor.transportation);
      case CategoryEnum.health:
        return CategoryInfo(
            name: 'Health',
            icon: Icons.health_and_safety,
            color: CategoryColor.health);
      case CategoryEnum.beauty:
        return CategoryInfo(
            name: 'Beauty', icon: Icons.spa, color: CategoryColor.beauty);
      case CategoryEnum.entertainment:
        return CategoryInfo(
            name: 'Entertainment',
            icon: Icons.sentiment_very_satisfied,
            color: CategoryColor.entertainment);
      case CategoryEnum.travel:
        return CategoryInfo(
            name: 'Travel',
            icon: Icons.flight_takeoff,
            color: CategoryColor.travel);
      default:
        return CategoryInfo(
            name: 'Others', icon: Icons.style, color: CategoryColor.others);
    }
  }

  bool isExpense() {
    return type.toLowerCase() == 'expense';
  }

  String getDisplayAmount() {
    return isExpense()
        ? '-¥${amount.toStringAsFixed(0)}'
        : '+¥${amount.toStringAsFixed(0)}';
  }

  String getDisplayCreatedAt() {
    return DateFormat.MMMMd()
        .add_Hm()
        .format(DateTime.parse(createdAt.toDate().toString()));
  }

  factory Transaction.fromFirebase(Map<String, dynamic> doc) => Transaction(
        id: doc['id'],
        type: doc['type'],
        name: doc['name'],
        categoryId: CategoryEnum.values[doc['categoryId'] - 1],
        amount: doc['amount'],
        note: doc['note'],
        createdAt: doc['createdAt'],
      );

  @override
  Map<String, dynamic> toFirebase() => {
        'type': type,
        'name': name,
        'categoryId': categoryId,
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
  List<Object?> get props => [id, type, name, categoryId, amount, createdAt];
}
