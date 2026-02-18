// lib/presentation/blocs/category/category_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/repositories/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _repository;

  CategoryBloc(this._repository) : super(CategoryInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onAddCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
    on<AutoAdjustCategories>(_onAutoAdjustCategories);
    on<UpdateCategorySpending>(_onUpdateCategorySpending);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading());
    try {
      final now = DateTime.now();
      final categories = await _repository.getCategoriesForMonth(now);
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> _onAddCategory(
    AddCategory event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is! CategoryLoaded) return;
    final current = (state as CategoryLoaded).categories;

    try {
      await _repository.saveCategory(event.category);
      emit(CategoryLoaded([...current, event.category]));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> _onUpdateCategory(
    UpdateCategory event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is! CategoryLoaded) return;
    final current = (state as CategoryLoaded).categories;

    try {
      await _repository.updateCategory(event.category);
      final updated = current
          .map((c) => c.id == event.category.id ? event.category : c)
          .toList();
      emit(CategoryLoaded(updated));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is! CategoryLoaded) return;
    final current = (state as CategoryLoaded).categories;

    try {
      await _repository.deleteCategory(event.id);
      final updated = current.where((c) => c.id != event.id).toList();
      emit(CategoryLoaded(updated));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> _onAutoAdjustCategories(
    AutoAdjustCategories event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is! CategoryLoaded) return;
    final current = (state as CategoryLoaded).categories;

    try {
      final adjusted = _autoAdjust(
        current,
        event.plannedIncome,
        event.actualIncome,
      );
      await _repository.saveCategories(adjusted);
      emit(CategoryLoaded(adjusted));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  Future<void> _onUpdateCategorySpending(
    UpdateCategorySpending event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is! CategoryLoaded) return;
    final current = (state as CategoryLoaded).categories;

    try {
      final category = current.firstWhere((c) => c.name == event.categoryName);
      final updated = category.copyWith(
        spentAmount: category.spentAmount + event.amount,
      );
      await _repository.updateCategory(updated);

      final newList = current
          .map((c) => c.name == event.categoryName ? updated : c)
          .toList();
      emit(CategoryLoaded(newList));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  List<Category> _autoAdjust(
    List<Category> categories,
    double planned,
    double actual,
  ) {
    if (actual >= planned) return categories;

    final deficit = planned - actual;
    var remainingDeficit = deficit;

    // Sort by priority (lowest first) and type
    final adjustable =
        categories.where((c) => c.isScalable && c.type != 'fixed').toList()
          ..sort((a, b) => a.priority.compareTo(b.priority));

    final fixedTotal = categories
        .where((c) => c.type == 'fixed')
        .fold<double>(0, (sum, c) => sum + c.plannedAmount);

    // First, reduce from lowest priority flexible categories
    final adjusted = <Category>[];

    for (final cat in categories) {
      if (cat.type == 'fixed') {
        adjusted.add(cat);
        continue;
      }

      if (remainingDeficit <= 0 || !cat.isScalable) {
        adjusted.add(cat);
        continue;
      }

      final maxReduction = cat.plannedAmount * 0.5; // Max 50% reduction
      final reduction = remainingDeficit > maxReduction
          ? maxReduction
          : remainingDeficit;

      adjusted.add(cat.copyWith(actualAmount: cat.plannedAmount - reduction));

      remainingDeficit -= reduction;
    }

    return adjusted;
  }
}
