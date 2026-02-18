// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'data/models/budget_model.dart';
import 'data/models/category_model.dart';
import 'data/models/transaction_model.dart';
import 'domain/repositories/budget_repository.dart';
import 'domain/repositories/budget_repository_impl.dart';
import 'domain/repositories/category_repository.dart';
import 'domain/repositories/category_repository_impl.dart';
import 'domain/repositories/transaction_repository.dart';
import 'domain/repositories/transaction_repository_impl.dart';
import 'presentation/blocs/budget/budget_bloc.dart';
import 'presentation/blocs/category/category_bloc.dart';
import 'presentation/blocs/transaction/transaction_bloc.dart';
import 'presentation/blocs/analytics/analytics_bloc.dart';
import 'services/biometric_service.dart';
import 'services/backup_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0A0E21),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([
    BudgetModelSchema,
    CategoryModelSchema,
    TransactionModelSchema,
  ], directory: dir.path);

  final budgetRepository = BudgetRepositoryImpl(isar);
  final categoryRepository = CategoryRepositoryImpl(isar);
  final transactionRepository = TransactionRepositoryImpl(isar);
  final biometricService = BiometricService();
  final backupService = BackupService(isar);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BudgetRepository>.value(value: budgetRepository),
        RepositoryProvider<CategoryRepository>.value(value: categoryRepository),
        RepositoryProvider<TransactionRepository>.value(
          value: transactionRepository,
        ),
        RepositoryProvider<BiometricService>.value(value: biometricService),
        RepositoryProvider<BackupService>.value(value: backupService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                BudgetBloc(budgetRepository)..add(LoadBudget()),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(categoryRepository)..add(LoadCategories()),
          ),
          BlocProvider(
            create: (context) =>
                TransactionBloc(transactionRepository)..add(LoadTransactions()),
          ),
          BlocProvider(
            create: (context) => AnalyticsBloc(
              budgetRepository: budgetRepository,
              categoryRepository: categoryRepository,
              transactionRepository: transactionRepository,
            )..add(LoadAnalytics()),
          ),
        ],
        child: const SpendLensApp(),
      ),
    ),
  );
}
