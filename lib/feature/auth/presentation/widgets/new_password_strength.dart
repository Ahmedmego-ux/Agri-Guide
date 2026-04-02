import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NewPasswordStrength extends StatelessWidget {
  const NewPasswordStrength({
    super.key,
    required this.passwordStrength,
    required this.strengthText,
    required this.strengthColor,
  });

  final double passwordStrength;
  final String strengthText;
  final Color strengthColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;
    final backgroundColor = theme.dividerColor.withOpacity(0.2);

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: passwordStrength,
            backgroundColor: backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(strengthColor),
            minHeight: 8,
          ),
        ),
        const Gap(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Password Strength:',
              style: TextStyle(fontSize: 13, color: textColor),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: strengthColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                strengthText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: strengthColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}