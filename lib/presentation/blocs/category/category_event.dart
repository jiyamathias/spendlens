// lib/presentation/blocs/category/category_event.dart
part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends CategoryEvent {}

class AddCategory extends CategoryEvent {
  final Category category;

  const AddCategory(this.category);

  @override
  List<Object> get props => [category];
}

class UpdateCategory extends CategoryEvent {
  final Category category;

  const UpdateCategory(this.category);

  @override
  List<Object> get props => [category];
}

class DeleteCategory extends CategoryEvent {
  final int id;

  const DeleteCategory(this.id);

  @override
  List<Object> get props => [id];
}

class AutoAdjustCategories extends CategoryEvent {
  final double plannedIncome;
  final double actualIncome;

  const AutoAdjustCategories(this.plannedIncome, this.actualIncome);

  @override
  List<Object> get props => [plannedIncome, actualIncome];
}

class UpdateCategorySpending extends CategoryEvent {
  final String categoryName;
  final double amount;

  const UpdateCategorySpending(this.categoryName, this.amount);

  @override
  List<Object> get props => [categoryName, amount];
}
