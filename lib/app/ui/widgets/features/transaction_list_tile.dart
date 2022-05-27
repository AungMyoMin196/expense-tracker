import 'package:expense_tracker/data/models/category_info.dart';
import 'package:expense_tracker/data/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({Key? key, required this.transaction})
      : super(key: key);

  final Transaction transaction;
  @override
  Widget build(BuildContext context) {
    CategoryInfo categoryInfo =
        CategoryInfo.getCategoryInfo(transaction.categoryId);
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: categoryInfo.color,
          child: Icon(
            categoryInfo.icon,
            color: Colors.white,
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.name,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              categoryInfo.name,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              transaction.getDisplayAmount(),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: transaction.isExpense() ? Colors.red : Colors.green,
              ),
            ),
            Text(
              transaction.getDisplayCreatedAt(),
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
