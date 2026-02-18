// lib/presentation/blocs/budget/budget_event.dart
part of 'budget_bloc.dart';

abstract class BudgetEvent extends Equatable {
  const BudgetEvent();

  @override
  List<Object> get props => [];
}

class LoadBudget extends BudgetEvent {}

class CreateBudget extends BudgetEvent {
  final double plannedIncome;

  const CreateBudget(this.plannedIncome);

  @override
  List<Object> get props => [plannedIncome];
}

class UpdatePlannedIncome extends BudgetEvent {
  final double income;

  const UpdatePlannedIncome(this.income);

  @override
  List<Object> get props => [income];
}

class ConfirmActualIncome extends BudgetEvent {
  final double income;

  const ConfirmActualIncome(this.income);

  @override
  List<Object> get props => [income];
}

class UpdateAllocation extends BudgetEvent {
  final double totalAllocated;

  const UpdateAllocation(this.totalAllocated);

  @override
  List<Object> get props => [totalAllocated];
}
