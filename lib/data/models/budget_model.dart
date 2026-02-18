// lib/data/models/budget_model.dart
import 'package:isar/isar.dart';

part 'budget_model.g.dart';

@collection
class BudgetModel {
  Id id = Isar.autoIncrement;

  double plannedIncome;
  double actualIncome;
  double totalAllocated;
  double totalSpent;
  DateTime month;
  bool isActive;
  double savingsRate;

  BudgetModel({
    this.plannedIncome = 0,
    this.actualIncome = 0,
    this.totalAllocated = 0,
    this.totalSpent = 0,
    required this.month,
    this.isActive = true,
    this.savingsRate = 0,
  });
}
