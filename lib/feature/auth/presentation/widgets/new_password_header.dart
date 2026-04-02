import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NewPasswordHeader extends StatelessWidget {
  const NewPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleColor = theme.textTheme.headlineMedium?.color ?? Colors.black87;
    final subtitleColor = theme.textTheme.bodyMedium?.color?.withOpacity(0.7) ?? Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create New Password',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: titleColor,
          ),
        ),
        const Gap(12),
        Text(
          'Create a strong password that you don\'t use on other sites.',
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