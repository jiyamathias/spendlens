// lib/presentation/blocs/analytics/analytics_event.dart
part of 'analytics_bloc.dart';

abstract class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object> get props => [];
}

class LoadAnalytics extends AnalyticsEvent {}

class CalculateDisciplineScore extends AnalyticsEvent {}
