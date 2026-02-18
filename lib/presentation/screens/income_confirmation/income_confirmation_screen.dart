// lib/presentation/screens/income_confirmation/income_confirmation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../blocs/budget/budget_bloc.dart';
import '../../blocs/category/category_bloc.dart';
import '../../widgets/glass_card.dart';

class IncomeConfirmationScreen extends StatefulWidget {
  const IncomeConfirmationScreen({super.key});

  @override
  State<IncomeConfirmationScreen> createState() =>
      _IncomeConfirmationScreenState();
}

class _IncomeConfirmationScreenState extends State<IncomeConfirmationScreen> {
  final _actualIncomeController = TextEditingController();
  bool _autoAdjust = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Confirm Income'),
      ),
      body: BlocBuilder<BudgetBloc, BudgetState>(
        builder: (context, budgetState) {
          if (budgetState is! BudgetLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final plannedIncome = budgetState.budget.plannedIncome;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Planned Income',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${plannedIncome.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Actual Income Received',
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _actualIncomeController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: '\$0.00',
                          prefixIcon: const Icon(
                            Icons.attach_money,
                            color: AppTheme.primaryBlue,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => _actualIncomeController.text =
                                plannedIncome.toString(),
                            icon: const Text(
                              'SAME',
                              style: TextStyle(
                                color: AppTheme.primaryBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Auto-adjust option
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, categoryState) {
                    if (categoryState is CategoryLoaded) {
                      final actualIncome =
                          double.tryParse(_actualIncomeController.text) ?? 0;
                      final difference = actualIncome - plannedIncome;

                      if (difference < 0) {
                        return GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    color: AppTheme.accentWarning,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Income is \$${difference.abs().toStringAsFixed(2)} lower than planned',
                                      style: const TextStyle(
                                        color: AppTheme.accentWarning,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'How would you like to handle this?',
                                style: TextStyle(color: AppTheme.textSecondary),
                              ),
                              const SizedBox(height: 12),
                              RadioListTile<bool>(
                                value: true,
                                groupValue: _autoAdjust,
                                onChanged: (v) =>
                                    setState(() => _autoAdjust = v!),
                                title: const Text(
                                  'Auto-adjust categories',
                                  style: TextStyle(color: AppTheme.textPrimary),
                                ),
                                subtitle: const Text(
                                  'Reduce flexible categories by priority',
                                  style: TextStyle(
                                    color: AppTheme.textMuted,
                                    fontSize: 12,
                                  ),
                                ),
                                activeColor: AppTheme.primaryBlue,
                              ),
                              RadioListTile<bool>(
                                value: false,
                                groupValue: _autoAdjust,
                                onChanged: (v) =>
                                    setState(() => _autoAdjust = v!),
                                title: const Text(
                                  'Manual adjustment',
                                  style: TextStyle(color: AppTheme.textPrimary),
                                ),
                                subtitle: const Text(
                                  'I will adjust categories myself',
                                  style: TextStyle(
                                    color: AppTheme.textMuted,
                                    fontSize: 12,
                                  ),
                                ),
                                activeColor: AppTheme.primaryBlue,
                              ),
                            ],
                          ),
                        );
                      } else if (difference > 0) {
                        return GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.celebration,
                                    color: AppTheme.accentSuccess,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Great! Extra \$${difference.toStringAsFixed(2)} received',
                                      style: const TextStyle(
                                        color: AppTheme.accentSuccess,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Suggestion: Add to savings or investment categories',
                                style: TextStyle(color: AppTheme.textSecondary),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final actualIncome =
                          double.tryParse(_actualIncomeController.text) ?? 0;
                      context.read<BudgetBloc>().add(
                        ConfirmActualIncome(actualIncome),
                      );

                      if (_autoAdjust && actualIncome < plannedIncome) {
                        context.read<CategoryBloc>().add(
                          AutoAdjustCategories(plannedIncome, actualIncome),
                        );
                      }

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: const Text(
                      'Confirm & Continue',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
