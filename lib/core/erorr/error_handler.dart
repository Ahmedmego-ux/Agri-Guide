// lib/core/error/error_handler.dart

import 'package:flutter/material.dart';

class ErrorHandler {
  // دالة لمعالجة أخطاء التسجيل
  static String handleAuthError(dynamic error) {
    String errorMessage = 'An unexpected error occurred';
    
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('email rate limit') || 
        errorString.contains('over_email_send_rate_limit')) {
      errorMessage = 'Too many attempts. Please wait a few minutes and try again.';
    }
    else if (errorString.contains('email already registered') || 
             errorString.contains('user already exists')) {
      errorMessage = 'This email is already registered. Please login instead.';
    }
    else if (errorString.contains('invalid email')) {
      errorMessage = 'The email address is not valid.';
    }
    else if (errorString.contains('weak password')) {
      errorMessage = 'Password is too weak. Please use a stronger password.';
    }
    else if (errorString.contains('network error') || 
             errorString.contains('internet')) {
      errorMessage = 'Network error. Please check your internet connection.';
    }
    else if (errorString.contains('timeout')) {
      errorMessage = 'Request timed out. Please try again.';
    }
   else if (errorString.contains('invalid login credentials')) {
    return 'Invalid email or password. Please try again.';
  }
 else if (errorString.contains('email not confirmed')) {
    return 'Please verify your email first.';
  }
  else if (errorString.contains('unexpected_failure')) {
  errorMessage = 'Failed to send email. Please try again.';
} else if (errorString.contains('same_password')) {
  errorMessage = 'New password must be different from the old password';
}else if (errorString.contains('least 6 characters')) {
  errorMessage = 'Password must be at least 6 characters';
}
    
    return errorMessage;
  }

  // دالة لعرض SnackBar مع الخطأ
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  // دالة لعرض SnackBar مع رسالة نجاح
  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}