import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:expense_tracker/blocs/transaction/index.dart';
import 'package:expense_tracker/define/enums/category_enum.dart';
import 'package:expense_tracker/define/enums/transaction_type_enum.dart';
import 'package:expense_tracker/models/category_info.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  late String transactionName;
  late num amount;
  String? note;
  TransactionTypeEnum type = TransactionTypeEnum.income;
  CategoryEnum categoryId = CategoryEnum.food;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(
            height: 30.0,
          ),
          const Text('Add Transaction',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(
            height: 15.0,
          ),
          TextField(
            autofocus: true,
            onChanged: (v) => transactionName = v,
            cursorColor: AppTheme.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Enter transaction name!',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1.0,
                    color: AppTheme.primaryColor,
                    style: BorderStyle.solid),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2.0,
                    color: AppTheme.primaryColor,
                    style: BorderStyle.solid),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          TextField(
            onChanged: (v) => amount = num.parse(v),
            cursorColor: AppTheme.primaryColor,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
              hintText: 'Enter amount',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1.0,
                    color: AppTheme.primaryColor,
                    style: BorderStyle.solid),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2.0,
                    color: AppTheme.primaryColor,
                    style: BorderStyle.solid),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          TextField(
            onChanged: (v) => note = v,
            cursorColor: AppTheme.primaryColor,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
              hintText: 'Enter note',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1.0,
                    color: AppTheme.primaryColor,
                    style: BorderStyle.solid),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 2.0,
                    color: AppTheme.primaryColor,
                    style: BorderStyle.solid),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0.0,
                    title: const Text('Income'),
                    leading: Transform.scale(
                      scale: 1.5,
                      child: Radio<TransactionTypeEnum>(
                        activeColor: AppTheme.primaryColor,
                        value: TransactionTypeEnum.income,
                        groupValue: type,
                        onChanged: (TransactionTypeEnum? value) {
                          setState(() {
                            type = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0.0,
                    title: const Text('Expense'),
                    leading: Transform.scale(
                      scale: 1.5,
                      child: Radio<TransactionTypeEnum>(
                        activeColor: AppTheme.primaryColor,
                        value: TransactionTypeEnum.expense,
                        groupValue: type,
                        onChanged: (TransactionTypeEnum? value) {
                          setState(() {
                            type = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text('Select category',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(
            height: 10.0,
          ),
          Wrap(
            spacing: 5.0,
            runSpacing: 1.0,
            children: CategoryEnum.values.map((ctgId) {
              return ChoiceChip(
                padding: const EdgeInsets.all(10.0),
                label: Text(
                  CategoryInfo.getCategoryInfo(ctgId).name,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                selected: categoryId == ctgId,
                selectedColor: AppTheme.primaryColor,
                onSelected: (bool selected) {
                  setState(() {
                    categoryId = ctgId;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<TransactionBloc>(context).add(AddTransactionEvent(
                  transaction: Transaction(
                      name: transactionName,
                      type: type == TransactionTypeEnum.income
                          ? 'income'
                          : 'expense',
                      categoryId: categoryId,
                      amount: amount,
                      note: note,
                      createdAt: firestore.Timestamp.now())));
              Navigator.pop(context);
            },
            child: const Text(
              'Add',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              minimumSize: const Size(double.infinity, 50.0),
            ),
          ),
        ],
      ),
    );
  }
}
