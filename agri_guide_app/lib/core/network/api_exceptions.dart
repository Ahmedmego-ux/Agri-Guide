import 'package:agri_guide_app/core/network/api_errors.dart';
import 'package:dio/dio.dart';


class ApiExceptions {
  
  static ApiErrors handleError(DioException error) {

    final code=error.response!.statusCode;
    final data=error.response?.data;
    if(data is Map<String,dynamic>&&data['message']!=null){
      return ApiErrors(message: data['message'],statusCode: code);
    }

    switch (error.type) {


      case DioExceptionType.connectionTimeout:
        return ApiErrors(message: "Connection timeout. Please try again.");

      case DioExceptionType.sendTimeout:
        return ApiErrors(message: "Send timeout. Please try again.");

      case DioExceptionType.receiveTimeout:
        return ApiErrors(message: "Receive timeout. Check your internet connection.");

      case DioExceptionType.badCertificate:
        return ApiErrors(message: "Bad SSL certificate.");

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return ApiErrors(message: "Request was cancelled.");

      case DioExceptionType.connectionError:
        return ApiErrors(message: "No internet connection.");

      case DioExceptionType.unknown:
        return ApiErrors(message: "Unexpected error occurred.");
    }
  }

  static ApiErrors _handleBadResponse(DioException error) {
    final status = error.response?.statusCode;

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
        return ApiErrors(message: "Internal server error.");
      case 503:
        return ApiErrors(message: "Service unavailable.");

      default:
        return ApiErrors(message: error.response?.statusMessage ?? "Unknown server error.");
    }
  }
}

