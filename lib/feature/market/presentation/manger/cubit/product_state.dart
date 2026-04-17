part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}
final class ProductLoading extends ProductState {}
final class ProductSuccess extends ProductState {
   final List<ProductEntity> products;
  @override
List<Object> get props => [products];

  ProductSuccess({required this.products});
}
final class ProductFailure extends ProductState {
  final String errmessage;

  ProductFailure( {required this.errmessage});
}
final class ProductLoadedState extends ProductState {
 final List<ProductEntity> filteredProducts;

  ProductLoadedState( {required this.filteredProducts});
}