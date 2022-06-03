import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/transaction.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitialState extends TransactionState {
  const TransactionInitialState();

  @override
  String toString() => 'TransactionInitialState';
}

class TransactionQueryParamsChangedState extends TransactionState {
  const TransactionQueryParamsChangedState({required this.queryParams});

  final TransactionQueryParams queryParams;

  @override
  String toString() => 'TransactionQueryParamsChangedState';
}

class TransactionLoadingState extends TransactionState {
  const TransactionLoadingState();

  @override
  String toString() => 'TransactionLoadingState';
}

class TransactionLoadedState extends TransactionState {
  const TransactionLoadedState({required this.transactions});

  final List<Transaction> transactions;

  @override
  String toString() => 'TransactionLoadedState';

  @override
  List<Object> get props => [transactions];
}

class TransactionAddedState extends TransactionState {
  const TransactionAddedState({required this.transaction});

  final Transaction transaction;

  @override
  String toString() => 'TransactionAddedState';
}

class TransactionRemovedState extends TransactionState {
  const TransactionRemovedState({required this.transaction});

  final Transaction transaction;

  @override
  String toString() => 'TransactionRemovedState';
}

class TransactionErrorState extends TransactionState {
  const TransactionErrorState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'TransactionErrorState';

  @override
  List<Object> get props => [errorMessage];
}
