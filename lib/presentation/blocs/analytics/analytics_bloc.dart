// lib/presentation/blocs/analytics/analytics_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/budget.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/transaction.dart';
import '../../../domain/repositories/budget_repository.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../../domain/repositories/transaction_repository.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final BudgetRepository budgetRepository;
  final CategoryRepository categoryRepository;
  final TransactionRepository transactionRepository;

  AnalyticsBloc({
    required this.budgetRepository,
    required this.categoryRepository,
    required this.transactionRepository,
  }) : super(AnalyticsInitial()) {
    on<LoadAnalytics>(_onLoadAnalytics);
    on<CalculateDisciplineScore>(_onCalculateDisciplineScore);
  }

  Future<void> _onLoadAnalytics(
    LoadAnalytics event,
    Emitter<AnalyticsState> emit,
  ) async {
    emit(AnalyticsLoading());
    try {
      final now = DateTime.now();

      final budget = await budgetRepository.getCurrentBudget();
      final categories = await categoryRepository.getCategoriesForMonth(now);
      final transactions = await transactionRepository.getTransactionsForMonth(
        now,
      );

      // Get previous month for comparison
      final prevMonth = DateTime(now.year, now.month - 1, 1);
      final prevBudget = await budgetRepository.getCurrentBudget();
      final prevCategories = await categoryRepository.getCategoriesForMonth(
        prevMonth,
      );

      final driftData = _calculateDrift(categories, transactions);
      final lifestyleCreep = _detectLifestyleCreep(categories, prevCategories);
      final volatilityIndex = _calculateVolatility(transactions);
      final stabilityScore = _calculateStabilityScore(budget, transactions);
      final disciplineScore = _calculateDisciplineScore(
        budget: budget,
        categories: categories,
        transactions: transactions,
      );

      emit(
        AnalyticsLoaded(
          budget: budget,
          categories: categories,
          transactions: transactions,
          driftData: driftData,
          lifestyleCreepDetected: lifestyleCreep,
          volatilityIndex: volatilityIndex,
          stabilityScore: stabilityScore,
          disciplineScore: disciplineScore,
        ),
      );
    } catch (e) {
      emit(AnalyticsError(e.toString()));
    }
  }

  Future<void> _onCalculateDisciplineScore(
    CalculateDisciplineScore event,
    Emitter<AnalyticsState> emit,
  ) async {
    // Implementation for recalculating score
  }

  Map<String, double> _calculateDrift(
    List<Category> categories,
    List<Transaction> transactions,
  ) {
    final drift = <String, double>{};
    final spendingByCategory = <String, double>{};

    for (final t in transactions) {
      spendingByCategory[t.categoryName] =
          (spendingByCategory[t.categoryName] ?? 0) + t.amount;
    }

    for (final cat in categories) {
      final spent = spendingByCategory[cat.name] ?? 0;
      drift[cat.name] = cat.plannedAmount > 0
          ? (spent - cat.plannedAmount) / cat.plannedAmount
          : 0;
    }

    return drift;
  }

  bool _detectLifestyleCreep(List<Category> current, List<Category> previous) {
    if (previous.isEmpty) return false;

    double currentDiscretionary = 0;
    double previousDiscretionary = 0;

    for (final cat in current) {
      if (cat.type == 'flexible') {
        currentDiscretionary += cat.spentAmount;
      }
    }

    for (final cat in previous) {
      if (cat.type == 'flexible') {
        previousDiscretionary += cat.spentAmount;
      }
    }

    return currentDiscretionary > previousDiscretionary * 1.2;
  }

  double _calculateVolatility(List<Transaction> transactions) {
    if (transactions.length < 2) return 0;

    final amounts = transactions.map((t) => t.amount).toList();
    final mean = amounts.reduce((a, b) => a + b) / amounts.length;

    final squaredDiffs = amounts.map((a) => (a - mean) * (a - mean));
    final variance = squaredDiffs.reduce((a, b) => a + b) / amounts.length;

    return variance / (mean * mean); // Coefficient of variation squared
  }

  double _calculateStabilityScore(
    Budget? budget,
    List<Transaction> transactions,
  ) {
    if (budget == null) return 0;

    final incomeVariance = budget.actualIncome > 0
        ? (budget.plannedIncome - budget.actualIncome).abs() /
              budget.plannedIncome
        : 0;

    return (1 - incomeVariance) * 100;
  }

  double _calculateDisciplineScore({
    Budget? budget,
    required List<Category> categories,
    required List<Transaction> transactions,
  }) {
    if (budget == null || categories.isEmpty) return 0;

    // 40% - Allocation adherence
    double allocationScore = 0;
    for (final cat in categories) {
      if (cat.plannedAmount > 0) {
        final adherence =
            1 -
            ((cat.spentAmount - cat.plannedAmount).abs() / cat.plannedAmount);
        allocationScore += adherence.clamp(0, 1);
      }
    }
    allocationScore = (allocationScore / categories.length) * 40;

    // 25% - Savings consistency
    final savingsRate = budget.actualIncome > 0
        ? (budget.actualIncome -
                  transactions.fold<double>(0, (sum, t) => sum + t.amount)) /
              budget.actualIncome
        : 0;
    final savingsScore = (savingsRate / 0.20).clamp(0, 1) * 25;

    // 15% - Priority protection
    final highPriorityCats = categories.where((c) => c.priority <= 2);
    double priorityScore = 0;
    if (highPriorityCats.isNotEmpty) {
      for (final cat in highPriorityCats) {
        if (cat.spentAmount <= cat.actualAmount) {
          priorityScore += 1;
        }
      }
      priorityScore = (priorityScore / highPriorityCats.length) * 15;
    }

    // 10% - Income variance management
    final incomeVariance = budget.plannedIncome > 0
        ? (budget.actualIncome - budget.plannedIncome).abs() /
              budget.plannedIncome
        : 0;
    final varianceScore = (1 - incomeVariance).clamp(0, 1) * 10;

    // 10% - Discretionary control
    final discretionary = categories.where((c) => c.type == 'flexible');
    double discretionaryScore = 0;
    if (discretionary.isNotEmpty) {
      for (final cat in discretionary) {
        if (cat.spentAmount <= cat.actualAmount * 0.9) {
          discretionaryScore += 1;
        }
      }
      discretionaryScore = (discretionaryScore / discretionary.length) * 10;
    }

    return allocationScore +
        savingsScore +
        priorityScore +
        varianceScore +
        discretionaryScore;
  }
}
