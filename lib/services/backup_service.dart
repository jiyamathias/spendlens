// lib/services/backup_service.dart
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:csv/csv.dart';

import '../data/models/transaction_model.dart';

class BackupService {
  final Isar isar;

  BackupService(this.isar);

  Future<String> exportToCSV() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/spendlens_backup.csv');

    final transactions = await isar.transactionModels.where().findAll();

    final rows = <List<dynamic>>[
      ['Date', 'Amount', 'Category', 'Type', 'Mood', 'Note'],
      ...transactions.map(
        (t) => [
          t.date.toIso8601String(),
          t.amount,
          t.categoryName,
          t.categoryType,
          t.mood,
          t.note ?? '',
        ],
      ),
    ];

    final csv = const ListToCsvConverter().convert(rows);
    await file.writeAsString(csv);

    return file.path;
  }

  Future<void> shareBackup() async {
    final path = await exportToCSV();
    await Share.shareXFiles([XFile(path)], text: 'SpendLens Backup');
  }

  Future<String> createLocalBackup() async {
    final directory = await getApplicationDocumentsDirectory();
    final backupDir = Directory('${directory.path}/backups');
    if (!await backupDir.exists()) {
      await backupDir.create();
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final backupFile = File('${backupDir.path}/backup_$timestamp.isar');

    await isar.copyToFile(backupFile.path);

    return backupFile.path;
  }

  Future<List<String>> getAvailableBackups() async {
    final directory = await getApplicationDocumentsDirectory();
    final backupDir = Directory('${directory.path}/backups');

    if (!await backupDir.exists()) return [];

    final files = await backupDir
        .list()
        .where((f) => f.path.endsWith('.isar'))
        .map((f) => f.path)
        .toList();

    files.sort((a, b) => b.compareTo(a));
    return files;
  }

  Future<void> restoreFromBackup(String path) async {
    // Implementation for restoring from backup
    // This would require closing Isar, replacing the file, and reopening
  }
}
