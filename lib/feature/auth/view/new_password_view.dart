// lib/feature/auth/view/new_password_view.dart
import 'package:agri_guide_app/feature/auth/widgets/custom_textformfiled.dart';
import 'package:agri_guide_app/feature/auth/widgets/custome_auth_buttom.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/auth_header.dart';


class NewPasswordView extends StatelessWidget {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFFF2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(20),
                
                // Auth Header
                const AuthHeader(),
                
                const Gap(40),
                
                // Title
                const Text(
                  'Create New Password',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                
                const Gap(12),
                
                // Description
                Text(
                  'Create a strong password that you don\'t use on other sites.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                
                const Gap(40),
                
                // New Password Field
                CustomeTextFormField(
                  hintText: 'Enter new password',
                  labelText: 'New Password',
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.green),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility_off, color: Colors.grey),
                  ),
                  controller: TextEditingController(),
                  isPassword: true,
                ),
                
                const Gap(16),
                
                // Password Strength Indicator (UI only)
                _buildPasswordStrength(),
                
                const Gap(24),
                
                // Confirm Password Field
                CustomeTextFormField(
                  hintText: 'Confirm new password',
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline, color: Colors.green),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility_off, color: Colors.grey),
                  ),
                  controller: TextEditingController(),
                  isPassword: true,
                ),
                
                const Gap(32),
                
                // Reset Button
                CustomAuthButton(
                  text: 'Reset Password',
                  onPressed: () {},
                ),
                
                const Gap(24),
                
                // Password Requirements (UI only)
                _buildPasswordRequirements(),
                
                const Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordStrength() {
    return Column(
      children: [
        // Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: 0.4, // قيمة ثابتة للـ UI
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            minHeight: 8,
          ),
        ),
        
        const Gap(8),
        
        // Strength Text
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Password Strength:',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Medium',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPasswordRequirements() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.green.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.rule,
                color: Colors.green[700],
                size: 20,
              ),
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
          
          _buildRequirementItem(
            icon: Icons.check_circle,
            text: 'At least 8 characters',
            isMet: true,
          ),
          
          const Gap(12),
          
          _buildRequirementItem(
            icon: Icons.circle_outlined,
            text: 'At least one uppercase letter (A-Z)',
            isMet: false,
          ),
          
          const Gap(12),
          
          _buildRequirementItem(
            icon: Icons.check_circle,
            text: 'At least one lowercase letter (a-z)',
            isMet: true,
          ),
          
          const Gap(12),
          
          _buildRequirementItem(
            icon: Icons.circle_outlined,
            text: 'At least one number (0-9)',
            isMet: false,
          ),
          
          const Gap(12),
          
          _buildRequirementItem(
            icon: Icons.circle_outlined,
            text: 'At least one special character (!@#\$%^&*)',
            isMet: false,
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem({
    required IconData icon,
    required String text,
    required bool isMet,
  }) {
    return Row(
      children: [
        Icon(
          icon,
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