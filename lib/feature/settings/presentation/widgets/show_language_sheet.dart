import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void showLanguageSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  'chooseLanguage'.tr(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),

                
                _LanguageTile(
                  flag: '🇺🇸',
                  language: 'English',
                  locale: const Locale('en'),
                  currentLocale: context.locale,
                  onTap: ()async {
                    context.setLocale(const Locale('en'));
                     final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('locale', 'en');
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 8),
                _LanguageTile(
                  flag: '🇪🇬',
                  language: 'العربية',
                  locale: const Locale('ar'),
                  currentLocale: context.locale,
                  onTap: () async{
                    context.setLocale(const Locale('ar'));
                     final prefs = await SharedPreferences.getInstance();
                    await prefs.setString('locale', 'ar');
                    Navigator.pop(context);
                  },
                ),

                const SizedBox(height: 8),
              ],
            ),
          );
        },
      );
    },
  );
}

class _LanguageTile extends StatelessWidget {
  final String flag;
  final String language;
  final Locale locale;
  final Locale currentLocale;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.flag,
    required this.language,
    required this.locale,
    required this.currentLocale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentLocale == locale;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                language,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? colorScheme.primary : null,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded,
                  color: colorScheme.primary, size: 22),
          ],
        ),
      ),
    );
  }
}