part of 'product_bloc.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class ProductGetHot extends ProductEvent {}

class ProductGetMaybeLike extends ProductEvent {}

class ProductGetByCategory extends ProductEvent {
  final Category category;
  final int? ignore;

  ProductGetByCategory({required this.category, this.ignore});
}
