import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:dio/dio.dart';

class CouponRepository extends Repository {
  Future<List<Coupon>> getAll() async {
    Map response = await httpManager.get(
      url: '/order/get-coupon',
    );
    List responseRaw = response['data'];
    List<Coupon> coupons = responseRaw.map((e) {
      return Coupon.fromJson(e);
    }).toList();
    return coupons;
  }
}
