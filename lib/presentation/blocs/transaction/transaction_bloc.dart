// lib/presentation/blocs/transaction/transaction_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/repositories/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository _repository;

  TransactionBloc(this._repository) : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransaction>(_onAddTransaction);
    on<DeleteTransaction>(_onDeleteTransaction);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      final now = DateTime.now();
      final transactions = await _repository.getTransactionsForMonth(now);
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> _onAddTransaction(
    AddTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    if (state is! TransactionLoaded) return;
    final current = (state as TransactionLoaded).transactions;

    try {
      await _repository.saveTransaction(event.transaction);
      emit(TransactionLoaded([event.transaction, ...current]));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    if (state is! TransactionLoaded) return;
    final current = (state as TransactionLoaded).transactions;

    try {
      await _repository.deleteTransaction(event.id);
      final updated = current.where((t) => t.id != event.id).toList();
      emit(TransactionLoaded(updated));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}
