import 'package:expense_tracker/data/models/transaction.dart';

abstract class TransactionEvent {
  const TransactionEvent();
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
}

class UpdateTransactionEvent extends TransactionEvent {
  const UpdateTransactionEvent({required this.transaction});

  final Transaction transaction;

  @override
  String toString() => 'UpdateTransactionEvent';
}

class RemoveTransactionEvent extends TransactionEvent {
  const RemoveTransactionEvent({required this.transaction});

  final Transaction transaction;

  @override
  String toString() => 'RemoveTransactionEvent';
}

class ChangeTransactionQueryParamsEvent extends TransactionEvent {
  const ChangeTransactionQueryParamsEvent({required this.queryParams});

  final TransactionQueryParams queryParams;

  @override
  String toString() => 'ChangeTransactionQueryParamsEvent';
}
