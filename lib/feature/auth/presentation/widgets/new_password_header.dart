import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';

class NewPasswordHeader extends StatelessWidget {
  const NewPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleColor =
        theme.textTheme.headlineMedium?.color ?? Colors.black87;
    final subtitleColor =
        theme.textTheme.bodyMedium?.color?.withOpacity(0.7) ?? Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'createNewPassword'.tr(), // ✅
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        const Gap(12),
        Text(
          'createStrongPassword'.tr(), // ✅
          style: TextStyle(
            fontSize: 15,
            color: subtitleColor,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}