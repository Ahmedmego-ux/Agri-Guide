import 'package:agri_guide_app/core/utils/pref_helpers.dart';
import 'package:dio/dio.dart';

class DioClient {
  final String baseUrl;
  late final Dio _dio;

  DioClient(this.baseUrl) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          "Content-Type": "application/json",
          "post_type": "product",
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelpers.gettoken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}