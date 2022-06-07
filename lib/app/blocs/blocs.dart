import 'package:expense_tracker/app/blocs/auth/index.dart';
import 'package:expense_tracker/app/blocs/transaction/transaction_bloc.dart';
import 'package:expense_tracker/data/repositories/auth_repository.dart';
import 'package:expense_tracker/data/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Blocs {
  static List<BlocProvider> provide() {
    return [
      BlocProvider<AuthBloc>(
        create: (BuildContext context) =>
            AuthBloc(context.read<AuthRepository>()),
      ),
      BlocProvider<TransactionBloc>(
        create: (BuildContext context) =>
            TransactionBloc(context.read<TransactionRepository>()),
      ),
    ];
  }
}
