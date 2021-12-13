import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:dio/dio.dart';

class ShippingRepository extends Repository {
  getAll() async {
    Map response = await httpManager.get(
      url: '/order/get-shipping-fee',
    );
    Shipping shipping = Shipping.fromJson(response['data']);
    return {
      'status': response['status'],
      'shipping': shipping,
    };
  }
}
