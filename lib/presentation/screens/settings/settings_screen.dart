// lib/presentation/screens/settings/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_theme.dart';
import '../../../services/biometric_service.dart';
import '../../../services/backup_service.dart';
import '../../widgets/glass_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _biometricEnabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final biometricService = context.read<BiometricService>();
    final enabled = await biometricService.isBiometricEnabled();
    setState(() {
      _biometricEnabled = enabled;
      _isLoading = false;
    });
  }

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
                      'Settings',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Customize your experience',
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
                // Security Section
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.security,
                              color: AppTheme.primaryBlue,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Security',
                                  style: TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Protect your financial data',
                                  style: TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (!_isLoading)
                        SwitchListTile(
                          value: _biometricEnabled,
                          onChanged: (value) async {
                            final biometricService = context
                                .read<BiometricService>();
                            if (value) {
                              final authenticated = await biometricService
                                  .authenticate();
                              if (authenticated) {
                                await biometricService.setBiometricEnabled(
                                  true,
                                );
                                setState(() => _biometricEnabled = true);
                              }
                            } else {
                              await biometricService.setBiometricEnabled(false);
                              setState(() => _biometricEnabled = false);
                            }
                          },
                          title: const Text(
                            'Biometric Lock',
                            style: TextStyle(color: AppTheme.textPrimary),
                          ),
                          subtitle: const Text(
                            'Use fingerprint or face ID',
                            style: TextStyle(
                              color: AppTheme.textMuted,
                              fontSize: 12,
                            ),
                          ),
                          secondary: const Icon(
                            Icons.fingerprint,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Data Management
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.accentSuccess.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.backup,
                              color: AppTheme.accentSuccess,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Data Management',
                                  style: TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Export and backup your data',
                                  style: TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildSettingTile(
                        icon: Icons.download,
                        title: 'Export to CSV',
                        subtitle: 'Download your transactions',
                        onTap: () async {
                          final backupService = context.read<BackupService>();
                          final path = await backupService.exportToCSV();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Exported to: $path')),
                          );
                        },
                      ),
                      const Divider(color: AppTheme.backgroundElevated),
                      _buildSettingTile(
                        icon: Icons.save,
                        title: 'Create Local Backup',
                        subtitle: 'Save a backup file',
                        onTap: () async {
                          final backupService = context.read<BackupService>();
                          final path = await backupService.createLocalBackup();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Backup created: $path')),
                          );
                        },
                      ),
                      const Divider(color: AppTheme.backgroundElevated),
                      _buildSettingTile(
                        icon: Icons.share,
                        title: 'Share Backup',
                        subtitle: 'Send backup via email or messaging',
                        onTap: () async {
                          final backupService = context.read<BackupService>();
                          await backupService.shareBackup();
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // About
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About',
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSettingTile(
                        icon: Icons.info_outline,
                        title: 'Version',
                        subtitle: '1.0.0',
                        onTap: () {},
                      ),
                      const Divider(color: AppTheme.backgroundElevated),
                      _buildSettingTile(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy Policy',
                        subtitle: 'How we handle your data',
                        onTap: () {},
                      ),
                      const Divider(color: AppTheme.backgroundElevated),
                      _buildSettingTile(
                        icon: Icons.help_outline,
                        title: 'Help & Support',
                        subtitle: 'Get assistance',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppTheme.textSecondary),
      title: Text(
        title,
        style: const TextStyle(
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.textMuted),
    );
  }
}
