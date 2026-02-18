// lib/data/repositories/transaction_repository_impl.dart
import 'package:isar/isar.dart';
import '../../data/models/transaction_model.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final Isar isar;

  TransactionRepositoryImpl(this.isar);

  @override
  Future<List<Transaction>> getTransactionsForMonth(DateTime month) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);

    final models = await isar.transactionModels
        .filter()
        .dateBetween(startOfMonth, endOfMonth)
        .sortByDateDesc()
        .findAll();

    return models.map(_toEntity).toList();
  }

  @override
  Future<List<Transaction>> getTransactionsByCategory(
    String categoryName,
    DateTime month,
  ) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);

    final models = await isar.transactionModels
        .filter()
        .categoryNameEqualTo(categoryName)
        .dateBetween(startOfMonth, endOfMonth)
        .findAll();

    return models.map(_toEntity).toList();
  }

  @override
  Future<void> saveTransaction(Transaction transaction) async {
    final model = _toModel(transaction);
    await isar.writeTxn(() async {
      await isar.transactionModels.put(model);
    });
  }

  @override
  Future<void> deleteTransaction(int id) async {
    await isar.writeTxn(() async {
      await isar.transactionModels.delete(id);
    });
  }

  @override
  Future<double> getTotalSpentForMonth(DateTime month) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final endOfMonth = DateTime(month.year, month.month + 1, 0);

    final total = await isar.transactionModels
        .filter()
        .dateBetween(startOfMonth, endOfMonth)
        .amountProperty()
        .sum();

    return total ?? 0;
  }

  @override
  Future<Map<String, double>> getSpendingByCategory(DateTime month) async {
    final transactions = await getTransactionsForMonth(month);
    final Map<String, double> spending = {};

    for (final t in transactions) {
      spending[t.categoryName] = (spending[t.categoryName] ?? 0) + t.amount;
    }

    return spending;
  }

  Transaction _toEntity(TransactionModel model) {
    return Transaction(
      id: model.id,
      amount: model.amount,
      categoryName: model.categoryName,
      categoryType: model.categoryType,
      date: model.date,
      mood: model.mood,
      note: model.note,
      createdAt: model.createdAt,
    );
  }

  TransactionModel _toModel(Transaction entity) {
    final model = TransactionModel(
      amount: entity.amount,
      categoryName: entity.categoryName,
      categoryType: entity.categoryType,
      date: entity.date,
      mood: entity.mood,
      note: entity.note,
      createdAt: entity.createdAt,
    );
    if (entity.id != null) {
      model.id = entity.id!;
    }
    return model;
  }
}
