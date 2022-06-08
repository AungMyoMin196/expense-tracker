import 'package:expense_tracker/app/blocs/auth/index.dart';
import 'package:expense_tracker/app/blocs/transaction/index.dart';
import 'package:expense_tracker/app/services/auth_service.dart';
import 'package:expense_tracker/data/repositories/auth_repository.dart';
import 'package:expense_tracker/data/repositories/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Blocs {
  static List<BlocProvider> provideGlobal() {
    return [
      BlocProvider<AuthBloc>(
        create: (BuildContext context) =>
            AuthBloc(context.read<AuthRepository>(), AuthService.instance),
      ),
    ];
  }

  static List<BlocProvider> provideAuthenticatedLevel() {
    return [
      BlocProvider<TransactionBloc>(
        create: (BuildContext context) =>
            TransactionBloc(context.read<TransactionRepository>()),
      ),
    ];
  }
}
