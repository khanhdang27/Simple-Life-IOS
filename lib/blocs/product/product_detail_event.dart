part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailEvent {}

class ProductDetailGet extends ProductDetailEvent {
  final int productId;

  ProductDetailGet({required this.productId});
}
