// lib/domain/entities/transaction.dart
class Transaction {
  final int? id;
  final double amount;
  final String categoryName;
  final String categoryType;
  final DateTime date;
  final String mood;
  final String? note;
  final DateTime createdAt;

  Transaction({
    this.id,
    required this.amount,
    required this.categoryName,
    required this.categoryType,
    required this.date,
    required this.mood,
    this.note,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Transaction copyWith({
    int? id,
    double? amount,
    String? categoryName,
    String? categoryType,
    DateTime? date,
    String? mood,
    String? note,
    DateTime? createdAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      categoryName: categoryName ?? this.categoryName,
      categoryType: categoryType ?? this.categoryType,
      date: date ?? this.date,
      mood: mood ?? this.mood,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
