import 'dart:async';

import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  CouponBloc() : super(CouponInitial());
  CouponRepository couponRepository = CouponRepository();

  @override
  Stream<CouponState> mapEventToState(
    CouponEvent event,
  ) async* {
    if (event is CouponGetAll) {
      var coupons = await couponRepository.getAll();
      yield CouponGetAllSuccess(coupons: coupons);
    }
  }
}
