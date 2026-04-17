import 'package:agri_guide_app/core/erorr/error_handler.dart';
import 'package:agri_guide_app/core/network/api_errors.dart';
import 'package:agri_guide_app/core/network/api_exceptions.dart';
import 'package:agri_guide_app/core/network/api_services.dart';
import 'package:agri_guide_app/feature/market/data/models/product_model.dart';
import 'package:dio/dio.dart';

abstract class ProductRemotDataSource {
  Future<List<ProductModel>>getProducts();
  Future<List<ProductModel>>getProductsByType(String type);

}
class RemotDataSourceImpl extends ProductRemotDataSource{
  final ApiServices _apiServices;

  RemotDataSourceImpl(this._apiServices);
  @override
  @override
Future<List<ProductModel>> getProducts() async {
  try {
    final data = await _apiServices.get('/products.json');

  

    List<dynamic> products;

    if (data is List) {
      products = data;
    } else if (data is Map<String, dynamic>) {
      products = data['products'] ?? [];
    } else {
      throw Exception("Invalid API format");
    }

    return products
        .map((e) => ProductModel.fromJson(e))
        .toList();
  } catch (e, stack) {
    print("REMOTE ERROR: $e");
    print(stack);
    rethrow;
  }
}

  @override
  Future<List<ProductModel>> getProductsByType(String type)async {
     try {
  final response= await _apiServices.get('/products.json?limit=250',
  query:
    {"s":type,
    'type': 'fertilizer'
    }
  
  );
   final List<dynamic> products = response.data['products'] ?? [];
   return products.map((e)=>ProductModel.fromJson(e)).toList();
} on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ErrorHandler.handlePostgrestError(e);
    }
  }
  
}