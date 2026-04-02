import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final Color? textColor;
  final Color? backgroundColor;

  const ProfileButton({
    super.key,
    required this.onPressed,
    required this.value,
    this.icon,
    this.iconColor,
    this.backgroundColor, this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colorScheme.primary, 
          foregroundColor: iconColor ?? colorScheme.onPrimary, 
         
          textStyle: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor ?? colorScheme.onPrimary),
              const SizedBox(width: 8),
            ],
            Text(
              value,
              style: textTheme.titleMedium?.copyWith(
                color:textColor?? colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}