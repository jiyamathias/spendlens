// lib/domain/repositories/transaction_repository.dart
import '../entities/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactionsForMonth(DateTime month);
  Future<List<Transaction>> getTransactionsByCategory(
    String categoryName,
    DateTime month,
  );
  Future<void> saveTransaction(Transaction transaction);
  Future<void> deleteTransaction(int id);
  Future<double> getTotalSpentForMonth(DateTime month);
  Future<Map<String, double>> getSpendingByCategory(DateTime month);
}
