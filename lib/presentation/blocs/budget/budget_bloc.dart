// lib/presentation/blocs/budget/budget_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/budget.dart';
import '../../../domain/repositories/budget_repository.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final BudgetRepository _repository;

  BudgetBloc(this._repository) : super(BudgetInitial()) {
    on<LoadBudget>(_onLoadBudget);
    on<CreateBudget>(_onCreateBudget);
    on<UpdatePlannedIncome>(_onUpdatePlannedIncome);
    on<ConfirmActualIncome>(_onConfirmActualIncome);
    on<UpdateAllocation>(_onUpdateAllocation);
  }

  Future<void> _onLoadBudget(
    LoadBudget event,
    Emitter<BudgetState> emit,
  ) async {
    emit(BudgetLoading());
    try {
      final budget = await _repository.getCurrentBudget();
      if (budget != null) {
        emit(BudgetLoaded(budget));
      } else {
        emit(BudgetEmpty());
      }
    } catch (e) {
      emit(BudgetError(e.toString()));
    }
  }

  Future<void> _onCreateBudget(
    CreateBudget event,
    Emitter<BudgetState> emit,
  ) async {
    try {
      final now = DateTime.now();
      final budget = Budget(
        plannedIncome: event.plannedIncome,
        month: DateTime(now.year, now.month, 1),
      );
      await _repository.saveBudget(budget);
      emit(BudgetLoaded(budget));
    } catch (e) {
      emit(BudgetError(e.toString()));
    }
  }

  Future<void> _onUpdatePlannedIncome(
    UpdatePlannedIncome event,
    Emitter<BudgetState> emit,
  ) async {
    if (state is! BudgetLoaded) return;
    final current = (state as BudgetLoaded).budget;

    try {
      final updated = current.copyWith(plannedIncome: event.income);
      await _repository.updateBudget(updated);
      emit(BudgetLoaded(updated));
    } catch (e) {
      emit(BudgetError(e.toString()));
    }
  }

  Future<void> _onConfirmActualIncome(
    ConfirmActualIncome event,
    Emitter<BudgetState> emit,
  ) async {
    if (state is! BudgetLoaded) return;
    final current = (state as BudgetLoaded).budget;

    try {
      final updated = current.copyWith(actualIncome: event.income);
      await _repository.updateBudget(updated);
      emit(BudgetLoaded(updated));
    } catch (e) {
      emit(BudgetError(e.toString()));
    }
  }

  Future<void> _onUpdateAllocation(
    UpdateAllocation event,
    Emitter<BudgetState> emit,
  ) async {
    if (state is! BudgetLoaded) return;
    final current = (state as BudgetLoaded).budget;

    try {
      final updated = current.copyWith(totalAllocated: event.totalAllocated);
      await _repository.updateBudget(updated);
      emit(BudgetLoaded(updated));
    } catch (e) {
      emit(BudgetError(e.toString()));
    }
  }
}
