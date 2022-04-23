import 'package:expense_tracker/define/enums/category_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction {
  String id;
  String type;
  String name;
  CategoryEnum categoryId;
  double amount;
  String? note;
  String createdAt;

  Transaction(
      {required this.id,
      required this.type,
      required this.name,
      required this.categoryId,
      required this.amount,
      this.note,
      required this.createdAt});

  Widget getCategoryIcon() {
    switch (categoryId) {
      case CategoryEnum.food:
        return const CircleAvatar(
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.lunch_dining,
            color: Colors.white,
          ),
        );
      case CategoryEnum.shopping:
        return const CircleAvatar(
          backgroundColor: Colors.purpleAccent,
          child: Icon(
            Icons.shopping_bag,
            color: Colors.white,
          ),
        );
      case CategoryEnum.transportation:
        return const CircleAvatar(
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(
            Icons.commute,
            color: Colors.white,
          ),
        );
      case CategoryEnum.health:
        return const CircleAvatar(
          backgroundColor: Colors.pink,
          child: Icon(
            Icons.health_and_safety,
            color: Colors.white,
          ),
        );
      case CategoryEnum.beauty:
        return const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(
            Icons.spa,
            color: Colors.white,
          ),
        );
      case CategoryEnum.entertainment:
        return const CircleAvatar(
          backgroundColor: Colors.orange,
          child: Icon(
            Icons.sentiment_very_satisfied,
            color: Colors.white,
          ),
        );
      case CategoryEnum.travel:
        return const CircleAvatar(
          backgroundColor: Colors.indigoAccent,
          child: Icon(
            Icons.flight_takeoff,
            color: Colors.white,
          ),
        );
      default:
        return const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(
            Icons.style,
            color: Colors.white,
          ),
        );
    }
  }

  String getCategoryName() {
    switch (categoryId) {
      case CategoryEnum.food:
        return 'Food';
      case CategoryEnum.shopping:
        return 'Shopping';
      case CategoryEnum.transportation:
        return 'Transportation';
      case CategoryEnum.health:
        return 'Health';
      case CategoryEnum.beauty:
        return 'Beauty';
      case CategoryEnum.entertainment:
        return 'Entertainment';
      case CategoryEnum.travel:
        return 'Travel';
      default:
        return 'Other';
    }
  }

  bool isExpense() {
    return type.toLowerCase() == 'expense';
  }

  String getDisplayAmount() {
    return isExpense() ? '-\$${amount.toString()}' : '+\$${amount.toString()}';
  }

  String getDisplayCreatedAt() {
    return DateFormat.MMMMd().add_Hm().format(DateTime.parse(createdAt));
  }
}
