import 'dart:convert';

import 'package:agri_guide_app/feature/market/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProductLocalDataSource {
   Future<void> cacheProducts(List<ProductModel> products); 
   Future<List<ProductModel>> getCachedProducts(); Future<void> clearCache();
    }

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences _prefs;

  static const String _cachedProductsKey = 'CACHED_PRODUCTS';
  static const String _cacheTimestampKey = 'CACHE_TIMESTAMP';
  static const Duration _cacheValidity = Duration(hours: 1);

  const ProductLocalDataSourceImpl(this._prefs);

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final jsonList = products.map((p) => p.toJson()).toList();

    await _prefs.setString(
      _cachedProductsKey,
      jsonEncode(jsonList),
    );

    await _prefs.setInt(
      _cacheTimestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final timestamp = _prefs.getInt(_cacheTimestampKey);

    if (timestamp != null) {
      final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

      if (DateTime.now().difference(cachedTime) > _cacheValidity) {
        await clearCache();
        
      }
    }

    final jsonString = _prefs.getString(_cachedProductsKey);

    if (jsonString == null) {
      throw 'your cach empity';
    }

    final List<dynamic> jsonList = jsonDecode(jsonString);

    return jsonList
        .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> clearCache() async {
    await _prefs.remove(_cachedProductsKey);
    await _prefs.remove(_cacheTimestampKey);
  }
}