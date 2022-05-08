import 'package:equatable/equatable.dart';
import 'package:expense_tracker/models/transaction.dart';

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

class TransactionLoadingState extends TransactionState {
  const TransactionLoadingState();

  @override
  String toString() => 'TransactionLoadingState';
}

class TransactionLoadedState extends TransactionState {
  const TransactionLoadedState(
      {required this.transactions, required this.transactionMonth});

  final List<Transaction> transactions;
  final String transactionMonth;

  @override
  String toString() => 'TransactionLoadedState';

  @override
  List<Object> get props => [transactions, transactionMonth];
}

class TransactionAddedState extends TransactionState {
  const TransactionAddedState();

  @override
  String toString() => 'TransactionAddedState';
}

class TransactionUpdatedState extends TransactionState {
  const TransactionUpdatedState();

  @override
  String toString() => 'TransactionUpdatedState';
}

class TransactionRemovedState extends TransactionState {
  const TransactionRemovedState();

  @override
  String toString() => 'TransactionRemovedState';
}

class TransactionQueryParamsChangedState extends TransactionState {
  const TransactionQueryParamsChangedState({required this.queryParams});

  final TransactionQueryParams queryParams;

  @override
  String toString() => 'TransactionQueryParamsChangedState';
}

class TransactionErrorState extends TransactionState {
  const TransactionErrorState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'TransactionErrorState';

  @override
  List<Object> get props => [errorMessage];
}
