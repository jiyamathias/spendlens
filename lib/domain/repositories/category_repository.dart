// lib/domain/repositories/category_repository.dart
import '../entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategoriesForMonth(DateTime month);
  Future<Category?> getCategoryById(int id);
  Future<void> saveCategory(Category category);
  Future<void> saveCategories(List<Category> categories);
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(int id);
  Future<void> deleteAllCategoriesForMonth(DateTime month);
}
