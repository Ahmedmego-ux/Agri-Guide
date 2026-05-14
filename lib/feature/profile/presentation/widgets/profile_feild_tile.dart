import 'package:flutter/material.dart';

class ProfileFieldTile extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final bool isEditing;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const ProfileFieldTile({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.isEditing,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final inputTheme = theme.inputDecorationTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon container
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),

          // Content
          Expanded(
            child: isEditing
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        controller: controller,
                        keyboardType: keyboardType,
                        validator: validator,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: inputTheme.fillColor,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 14,
                          ),
                          isDense: true,
                          border: inputTheme.border,
                          enabledBorder: inputTheme.enabledBorder,
                          focusedBorder: inputTheme.focusedBorder,
                          errorBorder: inputTheme.errorBorder,
                          focusedErrorBorder: inputTheme.focusedErrorBorder,
                          hintStyle: inputTheme.hintStyle,
                          errorStyle: inputTheme.errorStyle,
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        controller.text,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),

          // Edit mode indicator
          if (!isEditing)
            Icon(
              Icons.chevron_right_rounded,
              size: 18,
              color: colorScheme.onSurfaceVariant.withOpacity(0.4),
            ),
        ],
      ),
    );
  }
}