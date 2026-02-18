// lib/presentation/screens/plan/plan_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/entities/category.dart';
import '../../blocs/budget/budget_bloc.dart';
import '../../blocs/category/category_bloc.dart';
import '../../widgets/glass_card.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final _incomeController = TextEditingController();
  bool _showIncomeInput = false;

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
                      'Plan Mode',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Design your financial blueprint',
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
                // Income Section
                BlocBuilder<BudgetBloc, BudgetState>(
                  builder: (context, state) {
                    if (state is BudgetLoaded) {
                      return GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Planned Income',
                                  style: TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => setState(
                                    () => _showIncomeInput = !_showIncomeInput,
                                  ),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppTheme.primaryBlue,
                                  ),
                                ),
                              ],
                            ),
                            if (_showIncomeInput) ...[
                              const SizedBox(height: 12),
                              TextField(
                                controller: _incomeController
                                  ..text = state.budget.plannedIncome
                                      .toString(),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Enter monthly income',
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      final income =
                                          double.tryParse(
                                            _incomeController.text,
                                          ) ??
                                          0;
                                      context.read<BudgetBloc>().add(
                                        UpdatePlannedIncome(income),
                                      );
                                      setState(() => _showIncomeInput = false);
                                    },
                                    icon: const Icon(
                                      Icons.check,
                                      color: AppTheme.accentSuccess,
                                    ),
                                  ),
                                ),
                              ),
                            ] else ...[
                              const SizedBox(height: 8),
                              Text(
                                '\$${state.budget.plannedIncome.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            // Savings Rate Warning
                            if (state.budget.savingsRate <
                                AppConstants.minSavingsRate)
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppTheme.accentWarning.withOpacity(
                                    0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppTheme.accentWarning.withOpacity(
                                      0.3,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.warning_amber_rounded,
                                      color: AppTheme.accentWarning,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'Savings rate is below 20%. Consider reducing discretionary spending.',
                                        style: TextStyle(
                                          color: AppTheme.accentWarning
                                              .withOpacity(0.9),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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

                // Allocation Chart
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoaded) {
                      return GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Allocation Distribution',
                              style: TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 200,
                              child: BarChart(
                                BarChartData(
                                  alignment: BarChartAlignment.spaceAround,
                                  maxY: state.totalAllocated * 0.4,
                                  barTouchData: BarTouchData(enabled: false),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          final types = [
                                            'Fixed',
                                            'Flexible',
                                            'Growth',
                                          ];
                                          if (value.toInt() < types.length) {
                                            return Text(
                                              types[value.toInt()],
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
                                    leftTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                  ),
                                  gridData: const FlGridData(show: false),
                                  borderData: FlBorderData(show: false),
                                  barGroups: [
                                    BarChartGroupData(
                                      x: 0,
                                      barRods: [
                                        BarChartRodData(
                                          toY: state.fixedCategories.fold(
                                            0,
                                            (sum, c) => sum + c.plannedAmount,
                                          ),
                                          color: AppTheme.primaryBlue,
                                          width: 40,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 1,
                                      barRods: [
                                        BarChartRodData(
                                          toY: state.flexibleCategories.fold(
                                            0,
                                            (sum, c) => sum + c.plannedAmount,
                                          ),
                                          color: AppTheme.primaryPurple,
                                          width: 40,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ],
                                    ),
                                    BarChartGroupData(
                                      x: 2,
                                      barRods: [
                                        BarChartRodData(
                                          toY: state.growthCategories.fold(
                                            0,
                                            (sum, c) => sum + c.plannedAmount,
                                          ),
                                          color: AppTheme.accentSuccess,
                                          width: 40,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Unallocated Balance
                            BlocBuilder<BudgetBloc, BudgetState>(
                              builder: (context, budgetState) {
                                if (budgetState is BudgetLoaded) {
                                  final unallocated =
                                      budgetState.budget.plannedIncome -
                                      state.totalAllocated;
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: unallocated >= 0
                                          ? AppTheme.accentSuccess.withOpacity(
                                              0.2,
                                            )
                                          : AppTheme.accentDanger.withOpacity(
                                              0.2,
                                            ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Unallocated',
                                          style: TextStyle(
                                            color: AppTheme.textSecondary,
                                          ),
                                        ),
                                        Text(
                                          '\$${unallocated.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: unallocated >= 0
                                                ? AppTheme.accentSuccess
                                                : AppTheme.accentDanger,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 20),

                // Categories List
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Categories',
                                style: TextStyle(
                                  color: AppTheme.textPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () =>
                                    _showAddCategoryDialog(context),
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('Add'),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...state.categories.map((category) {
                            return _buildCategoryTile(context, category);
                          }).toList(),
                        ],
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

  Widget _buildCategoryTile(BuildContext context, Category category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: getTypeColor(category.type).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  getTypeIcon(category.type),
                  color: getTypeColor(category.type),
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${category.type.capitalize()} • Priority ${category.priority}',
                      style: const TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${category.plannedAmount.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (category.isScalable)
                    const Text(
                      'Scalable',
                      style: TextStyle(
                        color: AppTheme.accentSuccess,
                        fontSize: 10,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.3,
              backgroundColor: AppTheme.backgroundElevated,
              valueColor: AlwaysStoppedAnimation<Color>(
                getTypeColor(category.type),
              ),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddCategoryDialog(),
    );
  }

  Color getTypeColor(String type) {
    switch (type) {
      case 'fixed':
        return AppTheme.primaryBlue;
      case 'flexible':
        return AppTheme.primaryPurple;
      case 'growth':
        return AppTheme.accentSuccess;
      default:
        return AppTheme.primaryOrange;
    }
  }

  IconData getTypeIcon(String type) {
    switch (type) {
      case 'fixed':
        return Icons.lock_outline;
      case 'flexible':
        return Icons.tune;
      case 'growth':
        return Icons.trending_up;
      default:
        return Icons.category;
    }
  }
}

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedType = 'flexible';
  int _priority = 3;
  bool _isScalable = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppTheme.backgroundCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Category',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                hintText: 'e.g., Groceries',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Planned Amount',
                prefixText: '\$',
              ),
            ),
            const SizedBox(height: 16),
            const Text('Type', style: TextStyle(color: AppTheme.textSecondary)),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'fixed', label: Text('Fixed')),
                ButtonSegment(value: 'flexible', label: Text('Flexible')),
                ButtonSegment(value: 'growth', label: Text('Growth')),
              ],
              selected: {_selectedType},
              onSelectionChanged: (set) =>
                  setState(() => _selectedType = set.first),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Priority:',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
                const SizedBox(width: 16),
                ...List.generate(5, (index) {
                  final level = index + 1;
                  return GestureDetector(
                    onTap: () => setState(() => _priority = level),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: _priority == level
                            ? AppTheme.primaryBlue
                            : AppTheme.backgroundElevated,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '$level',
                          style: TextStyle(
                            color: _priority == level
                                ? Colors.white
                                : AppTheme.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              value: _isScalable,
              onChanged: (v) => setState(() => _isScalable = v),
              title: const Text(
                'Scalable',
                style: TextStyle(color: AppTheme.textPrimary),
              ),
              subtitle: const Text(
                'Allow auto-adjustment when income changes',
                style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final category = Category(
                        name: _nameController.text,
                        type: _selectedType,
                        priority: _priority,
                        isScalable: _isScalable,
                        plannedAmount:
                            double.tryParse(_amountController.text) ?? 0,
                        month: DateTime.now(),
                      );
                      context.read<CategoryBloc>().add(AddCategory(category));
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
