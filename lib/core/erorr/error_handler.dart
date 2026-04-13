import 'package:flutter/material.dart';
import 'package:postgrest/postgrest.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ErrorHandler {
  // ---------------------------
  // AUTH ERRORS
  // ---------------------------
  static String handleAuthError(Object error) {
    if (error is AuthApiException) {
      switch (error.code) {
        case 'user_already_exists':
          return 'This email is already registered. Please login instead.';
        case 'invalid_credentials':
          return 'Invalid email or password.';
        case 'email_not_confirmed':
          return 'Please verify your email first.';
        case 'weak_password':
          return 'Password is too weak.';
        case 'over_request_rate_limit':
        case 'over_email_send_rate_limit':
          return 'Too many attempts. Try again later.';
        case 'same_password':
          return 'New password must be different.';
        default:
          return error.message;
      }
    }

    return _genericError(error);
  }

  // ---------------------------
  // POSTGREST ERRORS
  // ---------------------------
  static String handlePostgrestError(Object error) {
    if (error is PostgrestException) {
      switch (error.code) {
        case '23503':
          return 'Related record not found.';
        case '23505':
          return 'This record already exists.';
        default:
          return error.message;
      }
    }

    return _genericError(error);
  }

  // ---------------------------
  // FALLBACK
  // ---------------------------
  static String _genericError(Object error) {
    final msg = error.toString().toLowerCase();

    if (msg.contains('network') || msg.contains('internet')) {
      return 'No internet connection.';
    }

    if (msg.contains('timeout')) {
      return 'Request timed out.';
    }

    return 'Something went wrong. Please try again.';
  }

  // ---------------------------
  // SNACKBAR ERROR
  // ---------------------------
  static void showErrorSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ---------------------------
  // SNACKBAR SUCCESS
  // ---------------------------
  static void showSuccessSnackBar(
    BuildContext context,
    String message,
  ) {
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