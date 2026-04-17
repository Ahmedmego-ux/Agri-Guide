import 'package:agri_guide_app/core/network/api_exceptions.dart';
import 'package:agri_guide_app/core/network/dio_client.dart';
import 'package:dio/dio.dart';

class ApiServices {
  final DioClient _dioClient = DioClient();

 Future<dynamic> get(
  String endpoint, {
  Map<String, dynamic>? query,
}) async {
  try {
    final response = await _dioClient.dio.get(
      endpoint,
      queryParameters: query,
    );

    return response.data;
  } on DioException catch (e) {
    throw ApiExceptions.handleError(e);
  }
}

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<dynamic> update(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.put(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await _dioClient.dio.delete(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
}