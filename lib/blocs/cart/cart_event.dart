part of 'cart_bloc.dart';

abstract class CartEvent {
  const CartEvent();
}

class CartAdd extends CartEvent {
  final int productId;
  final int quantity;

  CartAdd({required this.productId, required this.quantity});
}

class CartGet extends CartEvent {}

class CartRemove extends CartEvent {
  final int productId;

  CartRemove({required this.productId});
}

class CartMultipleRemove extends CartEvent {}

class CartSync extends CartEvent {}
