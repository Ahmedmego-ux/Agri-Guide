import 'package:agri_guide_app/core/utils/theme/mange_theme/cubit/theme_cubit.dart';
import 'package:agri_guide_app/feature/profile/presentation/manger/cubit/profile_cubit.dart';
import 'package:agri_guide_app/feature/profile/presentation/view/profile_view.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/help_faq_view.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/privacy_policy_view.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/settings_item.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/settings_toggle_item.dart';
import 'package:agri_guide_app/feature/settings/presentation/widgets/show_language_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    bool isDark() {
      final mode = context.watch<ThemeCubit>().state;
      if (mode == ThemeMode.system) {
        return MediaQuery.of(context).platformBrightness ==
            Brightness.dark;
      } else {
        return mode == ThemeMode.dark;
      }
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Header container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 52, 16, 24),
            decoration: BoxDecoration(
              color: cs.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -20,
                  right: -20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.07),
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Directionality.of(context) ==
                                  TextDirection.RTL
                              ? Icons.arrow_forward_ios_rounded
                              : Icons.arrow_back_ios_new_rounded,
                          color: cs.onPrimary,
                          size: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      'settings'.tr(),
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(context, 'profile'.tr()),
                  _buildSettingsGroup(context, [
                    SettingItem(
                      icon: Icons.person_outline,
                      iconBg: cs.primaryContainer,
                      iconColor: cs.onPrimaryContainer,
                      title: 'account'.tr(),
                      subtitle: 'manageProfile'.tr(),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<ProfileCubit>(),
                            child: ProfileView(),
                          ),
                        ),
                      ),
                    ),
                  ]),

                  _buildSectionHeader(context, 'preferences'.tr()),
                  _buildSettingsGroup(context, [
                    SettingItem(
                      icon: Icons.language_outlined,
                      iconBg: const Color(0xFFE8EAF6),
                      iconColor: const Color(0xFF3949AB),
                      title: 'language'.tr(),
                      subtitle: 'english'.tr(),
                      onTap: () =>showLanguageSheet(context),
                    ),
                    Divider(
                      height: 10,
                      indent: 68,
                      color: theme.dividerTheme.color,
                    ),
                    SettingToggleItem(
                      icon: Icons.dark_mode_outlined,
                      iconBg: const Color(0xFFEDE7F6),
                      iconColor: const Color(0xFF673AB7),
                      title: 'darkMode'.tr(),
                      subtitle: 'switchTheme'.tr(),
                      value: isDark(),
                      onChanged: (val) =>
                          context.read<ThemeCubit>().themeToggle(val),
                    ),
                  ]),

                  _buildSectionHeader(context, 'support'.tr()),
                  _buildSettingsGroup(context, [
                    SettingItem(
                      icon: Icons.help_outline,
                      iconBg: const Color(0xFFFFF8E1),
                      iconColor: const Color(0xFFF9A825),
                      title: 'helpFaq'.tr(),
                      subtitle: 'helpFaqSubtitle'.tr(),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HelpFaqView(),
                        ),
                      ),
                    ),
                    Divider(
                      height: 10,
                      indent: 68,
                      color: theme.dividerTheme.color,
                    ),
                    SettingItem(
                      icon: Icons.security_outlined,
                      iconBg: cs.surfaceContainerHighest,
                      iconColor: cs.onSurfaceVariant,
                      title: 'privacyPolicy'.tr(),
                      subtitle: 'privacySubtitle'.tr(),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PrivacyPolicyView(),
                        ),
                      ),
                    ),
                  ]),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
  ) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: cs.onSurfaceVariant,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(
    BuildContext context,
    List<Widget> items,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }
}