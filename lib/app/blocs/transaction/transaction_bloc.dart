import 'dart:developer' as developer;
import 'package:bloc/bloc.dart';
import 'package:expense_tracker/app/blocs/transaction/index.dart';
import 'package:expense_tracker/data/models/transaction.dart';
import 'package:expense_tracker/data/repositories/transaction_repository.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _transactionRepository;

  TransactionBloc(this._transactionRepository)
      : super(const TransactionInitialState()) {
    on<ChangeTransactionQueryParamsEvent>((event, emit) async {
      try {
        emit(const TransactionLoadingState());
        List<Transaction> transactions =
            await _transactionRepository.getCollection(event.queryParams);
        emit(TransactionLoadedState(transactions: transactions));
      } on Exception catch (e) {
        developer.log(e.toString());
        emit(TransactionErrorState(e.toString()));
      }
    });
    on<AddTransactionEvent>((event, emit) async {
      try {
        emit(const TransactionLoadingState());
        await _transactionRepository.setItem(item: event.transaction);
        emit(TransactionAddedState(transaction: event.transaction));
      } on Exception catch (e) {
        developer.log(e.toString());
        emit(TransactionErrorState(e.toString()));
      }
    });
    on<RemoveTransactionEvent>((event, emit) async {
      try {
        emit(const TransactionLoadingState());
        await _transactionRepository.removeItem(event.transaction.id!);
        emit(TransactionRemovedState(transaction: event.transaction));
      } on Exception catch (e) {
        developer.log(e.toString());
        emit(TransactionErrorState(e.toString()));
      }
    });
  }
}
