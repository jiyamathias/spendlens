// lib/presentation/screens/reflect/reflect_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../blocs/analytics/analytics_bloc.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/discipline_score_gauge.dart';

class ReflectScreen extends StatelessWidget {
  const ReflectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reflect Mode',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Analyze your financial behavior',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Discipline Score
                BlocBuilder<AnalyticsBloc, AnalyticsState>(
                  builder: (context, state) {
                    if (state is AnalyticsLoaded) {
                      return GlassCard(
                        child: Column(
                          children: [
                            const Text(
                              'Financial Discipline Score',
                              style: TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 24),
                            DisciplineScoreGauge(score: state.disciplineScore),
                            const SizedBox(height: 24),
                            // Score Breakdown
                            _buildScoreBreakdown(state.disciplineScore),
                          ],
                        ),
                      );
                    }
                    return const GlassCard(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Drift Analysis
                BlocBuilder<AnalyticsBloc, AnalyticsState>(
                  builder: (context, state) {
                    if (state is AnalyticsLoaded &&
                        state.driftData.isNotEmpty) {
                      return GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Budget Drift',
                                  style: TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.accentWarning.withOpacity(
                                      0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Live',
                                    style: TextStyle(
                                      color: AppTheme.accentWarning,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            ...state.driftData.entries.map((entry) {
                              final isOver = entry.value > 0;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          entry.key,
                                          style: const TextStyle(
                                            color: AppTheme.textPrimary,
                                          ),
                                        ),
                                        Text(
                                          '${isOver ? '+' : ''}${(entry.value * 100).toStringAsFixed(1)}%',
                                          style: TextStyle(
                                            color: isOver
                                                ? AppTheme.accentDanger
                                                : AppTheme.accentSuccess,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: (entry.value.abs()).clamp(0, 1),
                                        backgroundColor:
                                            AppTheme.backgroundElevated,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              isOver
                                                  ? AppTheme.accentDanger
                                                  : AppTheme.accentSuccess,
                                            ),
                                        minHeight: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 20),

                // Insights Grid
                BlocBuilder<AnalyticsBloc, AnalyticsState>(
                  builder: (context, state) {
                    if (state is AnalyticsLoaded) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildInsightCard(
                                  'Volatility Index',
                                  state.volatilityIndex.toStringAsFixed(2),
                                  Icons.show_chart,
                                  AppTheme.primaryPurple,
                                  'Lower is better',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildInsightCard(
                                  'Stability Score',
                                  '${state.stabilityScore.toStringAsFixed(0)}%',
                                  Icons.security,
                                  AppTheme.primaryBlue,
                                  'Income consistency',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          if (state.lifestyleCreepDetected)
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppTheme.accentDanger.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppTheme.accentDanger.withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.warning_rounded,
                                    color: AppTheme.accentDanger,
                                    size: 32,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Lifestyle Creep Detected',
                                          style: TextStyle(
                                            color: AppTheme.accentDanger,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Your discretionary spending has increased by >20% for 2 consecutive months.',
                                          style: TextStyle(
                                            color: AppTheme.accentDanger
                                                .withOpacity(0.8),
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 20),

                // Planned vs Actual
                BlocBuilder<AnalyticsBloc, AnalyticsState>(
                  builder: (context, state) {
                    if (state is AnalyticsLoaded) {
                      return GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Planned vs Actual',
                              style: TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 200,
                              child: LineChart(
                                LineChartData(
                                  gridData: const FlGridData(show: false),
                                  titlesData: FlTitlesData(
                                    leftTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          final labels = [
                                            'Week 1',
                                            'Week 2',
                                            'Week 3',
                                            'Week 4',
                                          ];
                                          if (value.toInt() < labels.length) {
                                            return Text(
                                              labels[value.toInt()],
                                              style: const TextStyle(
                                                color: AppTheme.textSecondary,
                                                fontSize: 12,
                                              ),
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(show: false),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: const [
                                        FlSpot(0, 300),
                                        FlSpot(1, 450),
                                        FlSpot(2, 400),
                                        FlSpot(3, 620),
                                      ],
                                      isCurved: true,
                                      color: AppTheme.primaryBlue,
                                      barWidth: 3,
                                      dotData: const FlDotData(show: false),
                                      belowBarData: BarAreaData(
                                        show: true,
                                        color: AppTheme.primaryBlue.withOpacity(
                                          0.1,
                                        ),
                                      ),
                                    ),
                                    LineChartBarData(
                                      spots: const [
                                        FlSpot(0, 250),
                                        FlSpot(1, 380),
                                        FlSpot(2, 520),
                                        FlSpot(3, 480),
                                      ],
                                      isCurved: true,
                                      color: AppTheme.accentSuccess,
                                      barWidth: 3,
                                      dotData: const FlDotData(show: false),
                                      belowBarData: BarAreaData(
                                        show: true,
                                        color: AppTheme.accentSuccess
                                            .withOpacity(0.1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildLegend('Planned', AppTheme.primaryBlue),
                                const SizedBox(width: 24),
                                _buildLegend('Actual', AppTheme.accentSuccess),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreBreakdown(double score) {
    final components = [
      {'label': 'Allocation Adherence', 'weight': '40%', 'value': score * 0.4},
      {'label': 'Savings Consistency', 'weight': '25%', 'value': score * 0.25},
      {'label': 'Priority Protection', 'weight': '15%', 'value': score * 0.15},
      {'label': 'Income Variance', 'weight': '10%', 'value': score * 0.10},
      {
        'label': 'Discretionary Control',
        'weight': '10%',
        'value': score * 0.10,
      },
    ];

    return Column(
      children: components.map((comp) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  comp['label'] as String,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  comp['weight'] as String,
                  style: const TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: ((comp['value'] as double) / 100).clamp(0, 1),
                    backgroundColor: AppTheme.backgroundElevated,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      score > 70
                          ? AppTheme.accentSuccess
                          : score > 40
                          ? AppTheme.accentWarning
                          : AppTheme.accentDanger,
                    ),
                    minHeight: 6,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInsightCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: AppTheme.textMuted, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
        ),
      ],
    );
  }
}
