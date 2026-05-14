import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String initials;
  final String fullName;

  const ProfileAvatar({
    super.key,
    required this.initials,
    required this.fullName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Center(
      child: Column(
        children: [
          // Avatar with ring
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: cs.primary.withOpacity(0.3),
                width: 2.5,
              ),
            ),
            child: Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    cs.primary,
                    cs.primary.withOpacity(0.75),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: cs.primary.withOpacity(0.3),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  initials,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: cs.onPrimary,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            fullName,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: cs.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}