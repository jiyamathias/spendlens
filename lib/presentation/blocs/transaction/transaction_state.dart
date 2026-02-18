// lib/presentation/blocs/transaction/transaction_state.dart
part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;

  const TransactionLoaded(this.transactions);

  double get totalSpent => transactions.fold(0, (sum, t) => sum + t.amount);

  Map<String, double> get spendingByCategory {
    final map = <String, double>{};
    for (final t in transactions) {
      map[t.categoryName] = (map[t.categoryName] ?? 0) + t.amount;
    }
    return map;
  }

  Map<String, int> get moodDistribution {
    final map = <String, int>{};
    for (final t in transactions) {
      map[t.mood] = (map[t.mood] ?? 0) + 1;
    }
    return map;
  }

  @override
  List<Object> get props => [transactions];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object> get props => [message];
}
