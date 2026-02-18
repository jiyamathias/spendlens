// lib/data/repositories/category_repository_impl.dart
import 'package:isar/isar.dart';
import '../../data/models/category_model.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final Isar isar;

  CategoryRepositoryImpl(this.isar);

  @override
  Future<List<Category>> getCategoriesForMonth(DateTime month) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    final models = await isar.categoryModels
        .filter()
        .monthEqualTo(startOfMonth)
        .findAll();

    return models.map(_toEntity).toList();
  }

  @override
  Future<Category?> getCategoryById(int id) async {
    final model = await isar.categoryModels.get(id);
    return model != null ? _toEntity(model) : null;
  }

  @override
  Future<void> saveCategory(Category category) async {
    final model = _toModel(category);
    await isar.writeTxn(() async {
      await isar.categoryModels.put(model);
    });
  }

  @override
  Future<void> saveCategories(List<Category> categories) async {
    final models = categories.map(_toModel).toList();
    await isar.writeTxn(() async {
      await isar.categoryModels.putAll(models);
    });
  }

  @override
  Future<void> updateCategory(Category category) async {
    if (category.id == null) return;
    final model = _toModel(category);
    model.id = category.id!;
    await isar.writeTxn(() async {
      await isar.categoryModels.put(model);
    });
  }

  @override
  Future<void> deleteCategory(int id) async {
    await isar.writeTxn(() async {
      await isar.categoryModels.delete(id);
    });
  }

  @override
  Future<void> deleteAllCategoriesForMonth(DateTime month) async {
    final startOfMonth = DateTime(month.year, month.month, 1);
    await isar.writeTxn(() async {
      final ids = await isar.categoryModels
          .filter()
          .monthEqualTo(startOfMonth)
          .idProperty()
          .findAll();
      await isar.categoryModels.deleteAll(ids);
    });
  }

  Category _toEntity(CategoryModel model) {
    return Category(
      id: model.id,
      name: model.name,
      type: model.type,
      priority: model.priority,
      isScalable: model.isScalable,
      plannedAmount: model.plannedAmount,
      actualAmount: model.actualAmount,
      spentAmount: model.spentAmount,
      month: model.month,
      isActive: model.isActive,
    );
  }

  CategoryModel _toModel(Category entity) {
    final model = CategoryModel(
      name: entity.name,
      type: entity.type,
      priority: entity.priority,
      isScalable: entity.isScalable,
      plannedAmount: entity.plannedAmount,
      actualAmount: entity.actualAmount,
      spentAmount: entity.spentAmount,
      month: entity.month,
      isActive: entity.isActive,
    );
    if (entity.id != null) {
      model.id = entity.id!;
    }
    return model;
  }
}
