part of 'coupon_bloc.dart';

@immutable
abstract class CouponState {}

class CouponInitial extends CouponState {}

class CouponGetAllSuccess extends CouponState {
  final List<Coupon> coupons;

  CouponGetAllSuccess({required this.coupons});
}
class CouponGetAllFailed extends CouponState{}
