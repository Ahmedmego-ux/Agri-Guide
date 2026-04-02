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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
         
          Expanded(
  child: isEditing
      ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
              label,
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
          TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              validator: validator,
              style: textTheme.bodyMedium, 
              decoration: InputDecoration(
               // labelText: label,
                labelStyle: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                filled: true,
                fillColor: inputTheme.fillColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), 
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
              ),
            ),
            const SizedBox(height: 2),
            Text(
              controller.text,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ],
        ),
),
        ],
      ),
    );
  }
}