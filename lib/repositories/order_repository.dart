import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:dio/dio.dart';

class OrderRepository extends Repository {
  Future<List<Order>> get() async {
    Map response = await httpManager.get(
      url: '/order/get',
    );
    List responseRaw = response['data'];
    List<Order> orders = responseRaw.map((e) {
      return Order.fromJson(e);
    }).toList();
    return orders;
  }

  Future<Map> confirm({
    String? address,
    String? delivery,
    String? method,
    int? fee,
    int? coupon,
  }) async {
    FormData formData = FormData.fromMap({
      'address': address,
      'delivery': delivery,
      'method': method,
      'fee': fee,
      'coupon': coupon,
    });
    Map response = await httpManager.post(
      url: '/order/add',
      data: formData,
    );
    return {
      'status': response['data']['status'],
      'link': response['data']['link']
    };
  }
}
