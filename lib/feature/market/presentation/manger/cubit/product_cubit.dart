import 'package:agri_guide_app/core/network/api_errors.dart';
import 'package:agri_guide_app/core/network/api_exceptions.dart';
import 'package:agri_guide_app/feature/market/domain/entity/product_entity.dart';
import 'package:agri_guide_app/feature/market/domain/repos/product_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.repo) : super(ProductInitial());
  final ProductRepo repo;
  List<ProductEntity> allProducts = [];
List<ProductEntity> filteredProducts = [];

  Future<void>getProducts()async{
    emit(ProductLoading());

final result = await repo.getProducts();

result.fold(
  (error) {
  
    emit(ProductFailure(errmessage: error.toString()));
  },
  (products) {
     allProducts = products;
        filteredProducts = products;
        print(products.length);
    emit(ProductSuccess(products: products));
  },
);

  }
void searchProducts(String query) {
  String normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[-_:]'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  bool fuzzyMatch(String text, String query) {
    int t = 0;
    int q = 0;

    while (t < text.length && q < query.length) {
      if (text[t] == query[q]) {
        q++;
      }
      t++;
    }

    return q == query.length;
  }

  final normalizedQuery = normalize(query);

  if (normalizedQuery.isEmpty) {
    filteredProducts = allProducts;
  } else {
    filteredProducts = allProducts.where((product) {
      final title = normalize(product.title ?? "");

      return title.contains(normalizedQuery) ||
          title.startsWith(normalizedQuery) ||
          fuzzyMatch(title, normalizedQuery);
    }).toList();
  }

  emit(ProductSuccess(products: List.from(filteredProducts)));
}



 

}
