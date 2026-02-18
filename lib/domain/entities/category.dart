// lib/domain/entities/category.dart
class Category {
  final int? id;
  final String name;
  final String type;
  final int priority;
  final bool isScalable;
  final double plannedAmount;
  final double actualAmount;
  final double spentAmount;
  final DateTime month;
  final bool isActive;

  Category({
    this.id,
    required this.name,
    required this.type,
    this.priority = 3,
    this.isScalable = true,
    this.plannedAmount = 0,
    this.actualAmount = 0,
    this.spentAmount = 0,
    required this.month,
    this.isActive = true,
  });

  double get remaining => actualAmount - spentAmount;
  double get usagePercentage =>
      actualAmount > 0 ? spentAmount / actualAmount : 0;
  double get driftPercentage =>
      plannedAmount > 0 ? (spentAmount - plannedAmount) / plannedAmount : 0;

  bool get isOverBudget => spentAmount > actualAmount;
  bool get isUnderBudget => spentAmount < actualAmount * 0.8;

  Category copyWith({
    int? id,
    String? name,
    String? type,
    int? priority,
    bool? isScalable,
    double? plannedAmount,
    double? actualAmount,
    double? spentAmount,
    DateTime? month,
    bool? isActive,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      isScalable: isScalable ?? this.isScalable,
      plannedAmount: plannedAmount ?? this.plannedAmount,
      actualAmount: actualAmount ?? this.actualAmount,
      spentAmount: spentAmount ?? this.spentAmount,
      month: month ?? this.month,
      isActive: isActive ?? this.isActive,
    );
  }
}
