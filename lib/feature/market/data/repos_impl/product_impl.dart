// feature/market/data/repos_impl/product_impl.dart

import 'package:agri_guide_app/core/network/api_errors.dart';
import 'package:agri_guide_app/core/network/api_exceptions.dart';
import 'package:agri_guide_app/feature/market/data/data_source/local_data_source.dart';
import 'package:agri_guide_app/feature/market/data/data_source/remot_data_source.dart';
import 'package:agri_guide_app/feature/market/domain/entity/product_entity.dart';
import 'package:agri_guide_app/feature/market/domain/repos/product_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ProductImpl implements ProductRepo {
  final ProductRemotDataSource remote;
  final ProductLocalDataSource local;

  const ProductImpl({
    required ProductRemotDataSource networkDataSource,
    required ProductLocalDataSource localDataSource,
  })  : remote = networkDataSource,
        local = localDataSource;

  @override
  Future<Either<ApiErrors, List<ProductEntity>>> getProducts() async {
    try {
      final products = await remote.getProducts();

      await local.cacheProducts(products);

      return Right(products);
    } catch (e, stack) {
      print("GET PRODUCTS ERROR: $e");
      print(stack);

      final error = _toApiError(e);

      // 🔥 fallback cache ONLY for network errors
      if (_isNetworkError(error.message)) {
        try {
          final cached = await local.getCachedProducts();

          if (cached.isNotEmpty) {
            return Right(cached);
          }
        } catch (cacheError) {
          print("CACHE ERROR: $cacheError");
        }
      }

      return Left(error);
    }
  }

  
  ApiErrors _toApiError(dynamic e) {
    if (e is DioException) {
      return ApiExceptions.handleError(e);
    }

    if (e is FormatException) {
      return ApiErrors(message: "Invalid response format.");
    }

    return ApiErrors(message: e.toString());
  }

  bool _isNetworkError(String message) {
    final msg = message.toLowerCase();
    return msg.contains("internet") ||
        msg.contains("timeout") ||
        msg.contains("connection");
  }
}