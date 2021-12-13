part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailGetSuccess extends ProductDetailState {
  final Product product;

  ProductDetailGetSuccess({required this.product});
}
