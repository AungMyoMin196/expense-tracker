import 'package:equatable/equatable.dart';
import 'package:expense_tracker/models/transaction.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactionEvent extends TransactionEvent {
  const LoadTransactionEvent();

  @override
  String toString() => 'LoadTransactionEvent';
}

class AddTransactionEvent extends TransactionEvent {
  const AddTransactionEvent({required this.transaction});

  final Transaction transaction;

  @override
  String toString() => 'AddTransactionEvent';

  @override
  List<Object> get props => [transaction];
}

class UpdateTransactionEvent extends TransactionEvent {
  const UpdateTransactionEvent({required this.transaction});

  final Transaction transaction;

  @override
  String toString() => 'UpdateTransactionEvent';

  @override
  List<Object> get props => [transaction];
}

class RemoveTransactionEvent extends TransactionEvent {
  const RemoveTransactionEvent({required this.transaction});

  final Transaction transaction;

  @override
  String toString() => 'RemoveTransactionEvent';

  @override
  List<Object> get props => [transaction];
}

class ChangeTransactionQueryParamsEvent extends TransactionEvent {
  const ChangeTransactionQueryParamsEvent({required this.queryParams});

  final TransactionQueryParams queryParams;

  @override
  String toString() => 'ChangeTransactionQueryParamsEvent';

  @override
  List<Object> get props => [queryParams];
}
