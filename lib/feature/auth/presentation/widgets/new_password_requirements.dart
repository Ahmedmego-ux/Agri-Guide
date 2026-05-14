import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NewPasswordRequirements extends StatelessWidget {
  const NewPasswordRequirements({
    super.key,
    required this.hasMinLength,
    required this.hasUppercase,
    required this.hasLowercase,
    required this.hasNumber,
    required this.hasSpecial,
  });

  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasNumber;
  final bool hasSpecial;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final successColor = theme.colorScheme.primary;
    final borderColor = theme.colorScheme.primary.withOpacity(0.2);
    final bgColor = theme.colorScheme.primary.withOpacity(0.05);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.rule, color: successColor, size: 20),
              const Gap(8),
              Text(
                'passwordRequirements'.tr(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: successColor,
                ),
              ),
            ],
          ),

          const Gap(16),

          _buildItem(
            'atLeast8Chars'.tr(),
            hasMinLength,
            theme,
          ),

          const Gap(12),

          _buildItem(
            'atLeastOneUppercase'.tr(),
            hasUppercase,
            theme,
          ),

          const Gap(12),

          _buildItem(
            'atLeastOneLowercase'.tr(),
            hasLowercase,
            theme,
          ),

          const Gap(12),

          _buildItem(
            'atLeastOneNumber'.tr(),
            hasNumber,
            theme,
          ),

          const Gap(12),

          _buildItem(
            'atLeastOneSpecial'.tr(),
            hasSpecial,
            theme,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String text, bool isMet, ThemeData theme) {
    final successColor = theme.colorScheme.primary;

    final defaultColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.6) ??
            Colors.grey;

    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle_outlined,
          size: 18,
          color: isMet ? successColor : defaultColor,
        ),

        const Gap(12),

        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isMet ? successColor : defaultColor,
              fontWeight:
                  isMet ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}