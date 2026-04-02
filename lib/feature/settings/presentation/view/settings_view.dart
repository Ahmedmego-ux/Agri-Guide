import 'package:agri_guide_app/feature/auth/domain/entitys/login_entity.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:agri_guide_app/feature/profile/presentation/view/profile_view.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/help_faq_view.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/privacy_policy_view.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/settings_item.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/settings_toggle_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatefulWidget {
  final LoginEntity loginEntity;

  const SettingsView({super.key, required this.loginEntity});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.appBarTheme.foregroundColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Settings'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, 'PROFILE'),
            _buildSettingsGroup(context, [
              SettingItem(
                icon: Icons.person_outline,
                iconBg: cs.primaryContainer,
                iconColor: cs.onPrimaryContainer,
                title: 'Account',
                subtitle: 'Manage your profile',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<ProfileCubit>(),
                      child: ProfileView(loginEntity: widget.loginEntity),
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 30),

            _buildSectionHeader(context, 'PREFERENCES'),
            _buildSettingsGroup(context, [
              SettingItem(
                icon: Icons.language_outlined,
                iconBg: const Color(0xFFE8EAF6),
                iconColor: const Color(0xFF3949AB),
                title: 'Language',
                subtitle: 'English',
                onTap: () {},
              ),
              Divider(height: 10, indent: 68, color: theme.dividerTheme.color),
              SettingToggleItem(
                icon: Icons.dark_mode_outlined,
                iconBg: const Color(0xFFEDE7F6),
                iconColor: const Color(0xFF673AB7),
                title: 'Dark Mode',
                subtitle: 'Switch to dark theme',
                value: _isDarkMode,
                onChanged: (val) => setState(() => _isDarkMode = val),
              ),
            ]),
            const SizedBox(height: 30),

            _buildSectionHeader(context, 'SUPPORT'),
            _buildSettingsGroup(context, [
              SettingItem(
                icon: Icons.help_outline,
                iconBg: const Color(0xFFFFF8E1),
                iconColor: const Color(0xFFF9A825),
                title: 'Help & FAQ',
                subtitle: 'Get answers to common questions',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpFaqView()),
                ),
              ),
              Divider(height: 10, indent: 68, color: theme.dividerTheme.color),
              SettingItem(
                icon: Icons.security_outlined,
                iconBg: cs.surfaceContainerHighest,
                iconColor: cs.onSurfaceVariant,
                title: 'Privacy Policy',
                subtitle: 'Learn how we protect your data',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicyView()),
                ),
              ),
            ]),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: cs.onSurfaceVariant,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, List<Widget> items) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: items),
    );
  }
}