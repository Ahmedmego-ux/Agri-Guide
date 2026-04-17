// core/network/api_exceptions.dart

import 'package:dio/dio.dart';
import 'api_errors.dart';

class ApiExceptions {
  static ApiErrors handleError(DioException error) {
    final response = error.response;
    final statusCode = response?.statusCode;
    final data = response?.data;

    // 🔥 No response (internet / server down)
    if (response == null) {
      return ApiErrors(
        message: _mapDioType(error.type),
        statusCode: null,
      );
    }

    // 🔥 backend message
    if (data is Map<String, dynamic> && data['message'] != null) {
      return ApiErrors(
        message: data['message'],
        statusCode: statusCode,
      );
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiErrors(message: "Request timeout.");

      case DioExceptionType.connectionError:
        return ApiErrors(message: "No internet connection.");

      case DioExceptionType.badCertificate:
        return ApiErrors(message: "SSL certificate error.");

      case DioExceptionType.cancel:
        return ApiErrors(message: "Request cancelled.");

      case DioExceptionType.badResponse:
        return _handleStatusCode(statusCode);

      case DioExceptionType.unknown:
      default:
        return ApiErrors(message: "Unexpected error occurred.");
    }
  }

  static ApiErrors _handleStatusCode(int? status) {
    switch (status) {
      case 400:
        return ApiErrors(message: "Bad request.");
      case 401:
        return ApiErrors(message: "Unauthorized.");
      case 403:
        return ApiErrors(message: "Forbidden.");
      case 404:
        return ApiErrors(message: "Not found.");
      case 500:
        return ApiErrors(message: "Server error.");
      case 503:
        return ApiErrors(message: "Service unavailable.");
      default:
        return ApiErrors(message: "Unknown server error.");
    }
  }

  static String _mapDioType(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout.";
      case DioExceptionType.sendTimeout:
        return "Send timeout.";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout.";
      case DioExceptionType.connectionError:
        return "No internet connection.";
      default:
        return "Network error.";
    }
  }
}