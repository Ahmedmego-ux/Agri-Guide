import 'package:flutter/material.dart';
import 'package:postgrest/postgrest.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorHandler {
  static String handleAuthError(dynamic error) {
  
    if (error is AuthApiException) {
      switch (error.code) {
        case 'user_already_exists':
          return 'This email is already registered. Please login instead.';
        case 'invalid_credentials':
          return 'Invalid email or password. Please try again.';
        case 'email_not_confirmed':
          return 'Please verify your email first.';
        case 'weak_password':
          return 'Password is too weak. Please use a stronger password.';
        case 'over_request_rate_limit':
        case 'over_email_send_rate_limit':
          return 'Too many attempts. Please wait a few minutes and try again.';
        case 'same_password':
          return 'New password must be different from the old password.';
        case 'unexpected_failure':
          return 'Failed to send email. Please try again.';
        default:
          return error.message;
      }
    }

    
    String errorMessage = 'An unexpected error occurred';
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('email rate limit') ||
        errorString.contains('over_email_send_rate_limit')) {
      errorMessage = 'Too many attempts. Please wait a few minutes and try again.';
    } else if (errorString.contains('email already registered') ||
        errorString.contains('user already exists')) {
      errorMessage = 'This email is already registered. Please login instead.';
    } else if (errorString.contains('invalid email')) {
      errorMessage = 'The email address is not valid.';
    } else if (errorString.contains('weak password')) {
      errorMessage = 'Password is too weak. Please use a stronger password.';
    } else if (errorString.contains('network error') ||
        errorString.contains('internet')) {
      errorMessage = 'Network error. Please check your internet connection.';
    } else if (errorString.contains('timeout')) {
      errorMessage = 'Request timed out. Please try again.';
    } else if (errorString.contains('invalid login credentials') ||
        errorString.contains('invalid_credentials')) {
      errorMessage = 'Invalid email or password. Please try again.';
    } else if (errorString.contains('email not confirmed')) {
      errorMessage = 'Please verify your email first.';
    } else if (errorString.contains('unexpected_failure')) {
      errorMessage = 'Failed to send email. Please try again.';
    } else if (errorString.contains('same_password')) {
      errorMessage = 'New password must be different from the old password';
    } else if (errorString.contains('least 6 characters')) {
      errorMessage = 'Password must be at least 6 characters';
    }

    return errorMessage;
  }

  static String handlePostgrestError(dynamic error) {
    if (error is PostgrestException) {
      switch (error.code) {
        case '23503':
          return 'Operation failed: related user does not exist.';
        case '23505':
          return 'Duplicate entry. This record already exists.';
        default:
          return 'Database error: ${error.message}';
      }
    } else {
      return error.toString();
    }
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
         
          textColor: Colors.white,
          onPressed: () {}, 
          label: '',
        ),
      ),
    );
  }

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


