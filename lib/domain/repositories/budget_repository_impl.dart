// lib/data/repositories/budget_repository_impl.dart
import 'package:isar/isar.dart';
import '../../data/models/budget_model.dart';
import '../../domain/entities/budget.dart';
import '../../domain/repositories/budget_repository.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final Isar isar;

  BudgetRepositoryImpl(this.isar);

  @override
  Future<Budget?> getCurrentBudget() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);

    final model = await isar.budgetModels
        .filter()
        .monthEqualTo(startOfMonth)
        .findFirst();

    return model != null ? _toEntity(model) : null;
  }

  @override
  Future<List<Budget>> getBudgetHistory() async {
    final models = await isar.budgetModels.where().sortByMonthDesc().findAll();

    return models.map(_toEntity).toList();
  }

  @override
  Future<void> saveBudget(Budget budget) async {
    final model = _toModel(budget);
    await isar.writeTxn(() async {
      await isar.budgetModels.put(model);
    });
  }

  @override
  Future<void> updateBudget(Budget budget) async {
    if (budget.id == null) return;
    final model = _toModel(budget)..id = budget.id!;
    await isar.writeTxn(() async {
      await isar.budgetModels.put(model);
    });
  }

  @override
  Future<void> deleteBudget(int id) async {
    await isar.writeTxn(() async {
      await isar.budgetModels.delete(id);
    });
  }

  Budget _toEntity(BudgetModel model) {
    return Budget(
      id: model.id,
      plannedIncome: model.plannedIncome,
      actualIncome: model.actualIncome,
      totalAllocated: model.totalAllocated,
      totalSpent: model.totalSpent,
      month: model.month,
      isActive: model.isActive,
      savingsRate: model.savingsRate,
    );
  }

  BudgetModel _toModel(Budget entity) {
    final model = BudgetModel(
      plannedIncome: entity.plannedIncome,
      actualIncome: entity.actualIncome,
      totalAllocated: entity.totalAllocated,
      totalSpent: entity.totalSpent,
      month: entity.month,
      isActive: entity.isActive,
      savingsRate: entity.savingsRate,
    );
    if (entity.id != null) {
      model.id = entity.id!;
    }
    return model;
  }
}
