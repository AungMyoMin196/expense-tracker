import 'package:expense_tracker/data/repositories/auth_repository.dart';
import 'package:expense_tracker/data/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Repositories {
  static List<RepositoryProvider> provide() {
    return [
      RepositoryProvider<AuthRepository>(
        create: (BuildContext context) => AuthRepository(),
      ),
      RepositoryProvider<TransactionRepository>(
        create: (BuildContext context) => TransactionRepository(),
      ),
    ];
  }
}
