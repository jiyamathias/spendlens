// lib/presentation/blocs/budget/budget_state.dart
part of 'budget_bloc.dart';

abstract class BudgetState extends Equatable {
  const BudgetState();

  @override
  List<Object> get props => [];
}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetLoaded extends BudgetState {
  final Budget budget;

  const BudgetLoaded(this.budget);

  @override
  List<Object> get props => [budget];
}

class BudgetEmpty extends BudgetState {}

class BudgetError extends BudgetState {
  final String message;

  const BudgetError(this.message);

  @override
  List<Object> get props => [message];
}
