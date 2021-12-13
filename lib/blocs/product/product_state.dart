part of 'product_bloc.dart';

abstract class ProductState {
  const ProductState();
}

class ProductDefault extends ProductState {}

class ProductGetHotSuccess extends ProductState {
  final List<Product> products;

  ProductGetHotSuccess({required this.products});
}

class ProductGetMaybeLikeSuccess extends ProductState {
  final List<Product> products;

  ProductGetMaybeLikeSuccess({required this.products});
}

class ProductGetByCategorySuccess extends ProductState {
  final List<Product> products;
  final Category category;

  ProductGetByCategorySuccess({required this.category, required this.products});
}
