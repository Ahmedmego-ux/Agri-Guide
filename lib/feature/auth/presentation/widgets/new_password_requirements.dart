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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.rule, color: Colors.green[700], size: 20),
              const Gap(8),
              Text(
                'Password Requirements',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.green[800],
                ),
              ),
            ],
          ),
          const Gap(16),
          _buildItem('At least 8 characters', hasMinLength),
          const Gap(12),
          _buildItem('At least one uppercase letter (A-Z)', hasUppercase),
          const Gap(12),
          _buildItem('At least one lowercase letter (a-z)', hasLowercase),
          const Gap(12),
          _buildItem('At least one number (0-9)', hasNumber),
          const Gap(12),
          _buildItem('At least one special character (!@#\$%^&*)', hasSpecial),
        ],
      ),
    );
  }

  Widget _buildItem(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle_outlined,
          size: 18,
          color: isMet ? Colors.green : Colors.grey.shade400,
        ),
        const Gap(12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isMet ? Colors.green[700] : Colors.grey[600],
              fontWeight: isMet ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}