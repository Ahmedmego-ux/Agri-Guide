import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    final isRTL = Directionality.of(context) == TextDirection.RTL;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            isRTL
                ? Icons.arrow_forward_ios_rounded
                : Icons.arrow_back_ios_rounded,
            color: theme.appBarTheme.foregroundColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('privacyPolicy'.tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF3949AB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.security_outlined,
                      color: cs.onPrimary, size: 32),
                  const SizedBox(height: 10),
                  Text(
                    'privacyPolicy'.tr(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'lastUpdated'.tr(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onPrimary.withOpacity(0.75),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _buildSection(
              context,
              icon: Icons.info_outline,
              iconColor: const Color(0xFF3949AB),
              iconBg: const Color(0xFFE8EAF6),
              title: 'privacyInfoTitle'.tr(),
              content: 'privacyInfoContent'.tr(),
            ),

            _buildSection(
              context,
              icon: Icons.visibility_outlined,
              iconColor: const Color(0xFF2E9E47),
              iconBg: const Color(0xFFE8F5E9),
              title: 'privacyUseTitle'.tr(),
              content: 'privacyUseContent'.tr(),
            ),

            _buildSection(
              context,
              icon: Icons.share_outlined,
              iconColor: const Color(0xFFE65100),
              iconBg: const Color(0xFFFFF3E0),
              title: 'privacyShareTitle'.tr(),
              content: 'privacyShareContent'.tr(),
            ),

            _buildSection(
              context,
              icon: Icons.lock_outline,
              iconColor: const Color(0xFF7B1FA2),
              iconBg: const Color(0xFFF3E5F5),
              title: 'privacySecurityTitle'.tr(),
              content: 'privacySecurityContent'.tr(),
            ),

            _buildSection(
              context,
              icon: Icons.person_outline,
              iconColor: const Color(0xFF1565C0),
              iconBg: const Color(0xFFE3F2FD),
              title: 'privacyRightsTitle'.tr(),
              content: 'privacyRightsContent'.tr(),
            ),

            _buildSection(
              context,
              icon: Icons.child_care_outlined,
              iconColor: const Color(0xFFE91E63),
              iconBg: const Color(0xFFFCE4EC),
              title: 'privacyChildrenTitle'.tr(),
              content: 'privacyChildrenContent'.tr(),
            ),

            _buildSection(
              context,
              icon: Icons.update_outlined,
              iconColor: const Color(0xFF00796B),
              iconBg: const Color(0xFFE0F2F1),
              title: 'privacyChangesTitle'.tr(),
              content: 'privacyChangesContent'.tr(),
            ),

            _buildSection(
              context,
              icon: Icons.email_outlined,
              iconColor: const Color(0xFF5D4037),
              iconBg: const Color(0xFFEFEBE9),
              title: 'privacyContactTitle'.tr(),
              content: 'privacyContactContent'.tr(),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String content,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cs.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}