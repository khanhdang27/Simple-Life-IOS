part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutConfirmSuccess extends CheckoutState {
  final String checkoutLink;

  CheckoutConfirmSuccess({required this.checkoutLink});
}

class CheckoutConfirmFail extends CheckoutState {}

class CheckoutConfirmLoading extends CheckoutState {}
