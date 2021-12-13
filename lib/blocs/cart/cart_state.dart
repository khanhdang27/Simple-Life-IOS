part of 'cart_bloc.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {}

class CartSuccess extends CartState {
  final List<Product> products;
  final int quantity;
  final double amount;
  final double discount;
  final double cost;

  CartSuccess({
    required this.products,
    this.quantity = 0,
    this.amount = 0,
    this.discount = 0,
    this.cost = 0,
  });
}

class CartShowSuccess extends CartState {}
