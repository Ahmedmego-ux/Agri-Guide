import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomeTextFormField extends StatelessWidget {
  const CustomeTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    required this.isPassword,
    this.prefixIcon,
    required this.labelText,
    this.validator,
    this.keyboardType,
    this.readOnly,
  });

  final String hintText;
  final String labelText;
  final IconButton? suffixIcon;
  final Icon? prefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            labelText.tr(), // ✅ ترجمة
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),

        // TextField
        TextFormField(
          readOnly: readOnly ?? false,
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'pleaseEnterField'.tr(args: [labelText.tr()]);
                }
                return null;
              },
          keyboardType: keyboardType,
          obscureText: isPassword,
          controller: controller,
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: theme.colorScheme.onSurface),
          decoration: InputDecoration(
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon!.icon,
                    color: theme.iconTheme.color,
                    size: theme.iconTheme.size,
                  )
                : null,
            suffixIcon: suffixIcon,
            hintText: hintText.tr(), // ✅ ترجمة
            hintStyle: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            filled: true,
            fillColor: theme.inputDecorationTheme.fillColor,
            contentPadding: theme.inputDecorationTheme.contentPadding,
            border: theme.inputDecorationTheme.border,
            enabledBorder: theme.inputDecorationTheme.enabledBorder,
            focusedBorder: theme.inputDecorationTheme.focusedBorder,
            errorBorder: theme.inputDecorationTheme.errorBorder,
            focusedErrorBorder:
                theme.inputDecorationTheme.focusedErrorBorder,
          ),
        ),
      ],
    );
  }
}