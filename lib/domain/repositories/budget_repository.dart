// lib/domain/repositories/budget_repository.dart
import '../entities/budget.dart';

abstract class BudgetRepository {
  Future<Budget?> getCurrentBudget();
  Future<List<Budget>> getBudgetHistory();
  Future<void> saveBudget(Budget budget);
  Future<void> updateBudget(Budget budget);
  Future<void> deleteBudget(int id);
}
