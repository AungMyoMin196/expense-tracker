import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:expense_tracker/app/blocs/transaction/transaction_bloc.dart';
import 'package:expense_tracker/app/blocs/transaction/transaction_event.dart';
import 'package:expense_tracker/app/services/auth_service.dart';
import 'package:expense_tracker/data/models/category_info.dart';
import 'package:expense_tracker/data/models/transaction.dart';
import 'package:expense_tracker/defines/enums/category_enum.dart';
import 'package:expense_tracker/defines/enums/transaction_type_enum.dart';
import 'package:expense_tracker/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class AddTransactionModal extends StatefulWidget {
  const AddTransactionModal({Key? key, this.name}) : super(key: key);

  final String? name;

  @override
  State<AddTransactionModal> createState() => _AddTransactionModalState();
}

class _AddTransactionModalState extends State<AddTransactionModal> {
  late String transactionName;
  late num amount;
  String? note;
  TransactionTypeEnum typeId = TransactionTypeEnum.income;
  CategoryEnum categoryId = CategoryEnum.food;

  final _formKey = GlobalKey<FormBuilderState>();

  void _onSubmit() {
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    BlocProvider.of<TransactionBloc>(context).add(
      AddTransactionEvent(
        transaction: Transaction(
          uid: AuthService.instance.user!.uid,
          name: _formKey.currentState!.value['name'],
          typeId: typeId,
          categoryId: categoryId,
          amount: num.parse(_formKey.currentState!.value['amount']),
          date: firestore.Timestamp.fromDate(
              _formKey.currentState!.value['date']),
          note: _formKey.currentState!.value['note'],
          createdAt: firestore.Timestamp.now(),
        ),
      ),
    );
    Navigator.pop(context);
  }

  void _onCancel() {
    _formKey.currentState!.reset();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            // height: MediaQuery.of(context).size.height * 0.95,
            child: FormBuilder(
              key: _formKey,
              autoFocusOnValidationFailure: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Text(
                    'Add Transaction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  FormBuilderTextField(
                    name: 'name',
                    cursorColor: AppTheme.primaryColor,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.maxLength(30),
                      ],
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter transaction name!',
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  FormBuilderTextField(
                    name: 'amount',
                    cursorColor: AppTheme.primaryColor,
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(9999999),
                      ],
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      hintText: 'Enter amount',
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  FormBuilderDateTimePicker(
                    name: 'date',
                    inputType: InputType.date,
                    cursorColor: AppTheme.primaryColor,
                    validator: FormBuilderValidators.required(),
                    format: DateFormat('yyyy/MM/dd'),
                    decoration: const InputDecoration(
                      hintText: 'Select date',
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  FormBuilderTextField(
                    name: 'note',
                    cursorColor: AppTheme.primaryColor,
                    validator: FormBuilderValidators.maxLength(100),
                    decoration: const InputDecoration(
                      hintText: 'Enter note',
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
                                groupValue: typeId,
                                onChanged: (TransactionTypeEnum? value) {
                                  setState(() {
                                    typeId = value!;
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
                                groupValue: typeId,
                                onChanged: (TransactionTypeEnum? value) {
                                  setState(() {
                                    typeId = value!;
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
                  const Text(
                    'Select category',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
                    onPressed: _onSubmit,
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
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                    onPressed: _onCancel,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.accentColor,
                      minimumSize: const Size(double.infinity, 50.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
