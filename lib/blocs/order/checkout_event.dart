part of 'checkout_bloc.dart';

@immutable
abstract class CheckoutEvent {}

class CheckoutConfirm extends CheckoutEvent {
  final String? address;
  final String? method;
  final String? delivery;
  final int? fee;
  final int? coupon;

  CheckoutConfirm({this.address, this.method, this.delivery, this.fee, this.coupon});
}
