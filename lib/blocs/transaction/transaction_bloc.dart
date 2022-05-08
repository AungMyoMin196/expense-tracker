import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:expense_tracker/blocs/transaction/index.dart';
import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/services/transaction_service.dart';
import 'package:intl/intl.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final _transactionService = TransactionService();

  TransactionBloc() : super(const TransactionInitialState()) {
    on<LoadTransactionEvent>((event, emit) async {
      try {
        emit(const TransactionLoadingState());
        List<Transaction> transactions =
            await _transactionService.getCollection(null);
        emit(TransactionLoadedState(
            transactions: transactions,
            transactionMonth: DateFormat.MMMM().format(DateTime.now())));
      } on Exception catch (e) {
        developer.log(e.toString());
        emit(TransactionErrorState(e.toString()));
      }
    });
    on<AddTransactionEvent>((event, emit) async {
      try {
        emit(const TransactionLoadingState());
        await _transactionService.setItem(item: event.transaction);
        emit(const TransactionAddedState());
      } on Exception catch (e) {
        developer.log(e.toString());
        emit(TransactionErrorState(e.toString()));
      }
    });
    on<UpdateTransactionEvent>((event, emit) async {
      try {
        emit(const TransactionLoadingState());
        await _transactionService.setItem(item: event.transaction);
        emit(const TransactionUpdatedState());
      } on Exception catch (e) {
        developer.log(e.toString());
        emit(TransactionErrorState(e.toString()));
      }
    });
    on<RemoveTransactionEvent>((event, emit) async {
      try {
        emit(const TransactionLoadingState());
        await _transactionService.removeItem(event.transaction.id!);
        emit(const TransactionRemovedState());
      } on Exception catch (e) {
        developer.log(e.toString());
        emit(TransactionErrorState(e.toString()));
      }
    });
    on<ChangeTransactionQueryParamsEvent>((event, emit) async {
      try {
        emit(const TransactionLoadingState());
        List<Transaction> transactions =
            await _transactionService.getCollection(event.queryParams);
        String transactionMonth = DateFormat.MMMM().format(DateTime.now());
        if (event.queryParams?.createdAtFrom != null) {
          transactionMonth = DateFormat.MMMM()
              .format(event.queryParams!.createdAtFrom!.toDate());
        }
        emit(TransactionLoadedState(
            transactions: transactions, transactionMonth: transactionMonth));
      } on Exception catch (e) {
        developer.log(e.toString());
        emit(TransactionErrorState(e.toString()));
      }
    });
  }
}
