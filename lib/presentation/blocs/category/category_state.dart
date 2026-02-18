// lib/presentation/blocs/category/category_state.dart
part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  const CategoryLoaded(this.categories);

  double get totalAllocated =>
      categories.fold(0, (sum, c) => sum + c.plannedAmount);
  double get totalSpent => categories.fold(0, (sum, c) => sum + c.spentAmount);

  List<Category> get fixedCategories =>
      categories.where((c) => c.type == 'fixed').toList();
  List<Category> get flexibleCategories =>
      categories.where((c) => c.type == 'flexible').toList();
  List<Category> get growthCategories =>
      categories.where((c) => c.type == 'growth').toList();

  @override
  List<Object> get props => [categories];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object> get props => [message];
}
