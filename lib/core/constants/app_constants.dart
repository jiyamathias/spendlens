// lib/core/constants/app_constants.dart
class AppConstants {
  static const String appName = 'SpendLens';
  static const String appTagline = 'Financial Intelligence Engine';

  static const double minSavingsRate = 0.20;
  static const double lifestyleCreepThreshold = 0.20;

  static const Map<String, List<String>> categoryTypes = {
    'fixed': ['Rent', 'Utilities', 'Insurance', 'Subscriptions'],
    'flexible': ['Groceries', 'Transportation', 'Dining', 'Entertainment'],
    'growth': ['Investments', 'Education', 'Skills', 'Health'],
  };

  static const Map<String, String> moodEmojis = {
    'planned': '🎯',
    'impulse': '⚡',
    'emergency': '🚨',
    'social': '👥',
    'necessary': '✅',
  };

  static const List<String> moods = [
    'planned',
    'impulse',
    'emergency',
    'social',
    'necessary',
  ];
}
