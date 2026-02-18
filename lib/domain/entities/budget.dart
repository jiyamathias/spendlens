// lib/domain/entities/budget.dart
class Budget {
  final int? id;
  final double plannedIncome;
  final double actualIncome;
  final double totalAllocated;
  final double totalSpent;
  final DateTime month;
  final bool isActive;
  final double savingsRate;

  Budget({
    this.id,
    required this.plannedIncome,
    this.actualIncome = 0,
    this.totalAllocated = 0,
    this.totalSpent = 0,
    required this.month,
    this.isActive = true,
    this.savingsRate = 0,
  });

  double get unallocated => plannedIncome - totalAllocated;
  double get remaining => actualIncome - totalSpent;
  double get allocatedPercentage =>
      plannedIncome > 0 ? totalAllocated / plannedIncome : 0;

  Budget copyWith({
    int? id,
    double? plannedIncome,
    double? actualIncome,
    double? totalAllocated,
    double? totalSpent,
    DateTime? month,
    bool? isActive,
    double? savingsRate,
  }) {
    return Budget(
      id: id ?? this.id,
      plannedIncome: plannedIncome ?? this.plannedIncome,
      actualIncome: actualIncome ?? this.actualIncome,
      totalAllocated: totalAllocated ?? this.totalAllocated,
      totalSpent: totalSpent ?? this.totalSpent,
      month: month ?? this.month,
      isActive: isActive ?? this.isActive,
      savingsRate: savingsRate ?? this.savingsRate,
    );
  }
}
