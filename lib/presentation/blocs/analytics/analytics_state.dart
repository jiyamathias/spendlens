// lib/presentation/blocs/analytics/analytics_state.dart
part of 'analytics_bloc.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();

  @override
  List<Object> get props => [];
}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoading extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {
  final Budget? budget;
  final List<Category> categories;
  final List<Transaction> transactions;
  final Map<String, double> driftData;
  final bool lifestyleCreepDetected;
  final double volatilityIndex;
  final double stabilityScore;
  final double disciplineScore;

  const AnalyticsLoaded({
    this.budget,
    required this.categories,
    required this.transactions,
    required this.driftData,
    required this.lifestyleCreepDetected,
    required this.volatilityIndex,
    required this.stabilityScore,
    required this.disciplineScore,
  });

  @override
  List<Object> get props => [
    categories,
    transactions,
    driftData,
    lifestyleCreepDetected,
    volatilityIndex,
    stabilityScore,
    disciplineScore,
  ];
}

class AnalyticsError extends AnalyticsState {
  final String message;

  const AnalyticsError(this.message);

  @override
  List<Object> get props => [message];
}
