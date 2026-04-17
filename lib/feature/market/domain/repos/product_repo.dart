import 'package:dartz/dartz.dart';
import 'package:agri_guide_app/core/network/api_errors.dart';
import 'package:agri_guide_app/feature/market/domain/entity/product_entity.dart';

abstract class ProductRepo {
  Future<Either<ApiErrors, List<ProductEntity>>> getProducts();

  
}