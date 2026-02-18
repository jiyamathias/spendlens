// lib/data/models/transaction_model.dart
import 'package:isar/isar.dart';

part 'transaction_model.g.dart';

@collection
class TransactionModel {
  Id id = Isar.autoIncrement;

  double amount;
  String categoryName;
  String categoryType;
  DateTime date;
  String mood;
  String? note;
  DateTime createdAt;

  TransactionModel({
    required this.amount,
    required this.categoryName,
    required this.categoryType,
    required this.date,
    required this.mood,
    this.note,
    required this.createdAt,
  });
}
