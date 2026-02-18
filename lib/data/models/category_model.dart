// lib/data/models/category_model.dart
import 'package:isar/isar.dart';

part 'category_model.g.dart';

@collection
class CategoryModel {
  Id id = Isar.autoIncrement;

  String name;
  String type; // fixed, flexible, growth
  int priority; // 1-5
  bool isScalable;
  double plannedAmount;
  double actualAmount;
  double spentAmount;
  DateTime month;
  bool isActive;

  CategoryModel({
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
}
