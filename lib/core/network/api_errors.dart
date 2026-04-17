// core/network/api_errors.dart

class ApiErrors {
  final String message;
  final int? statusCode;

  ApiErrors({
    required this.message,
    this.statusCode,
  });
}