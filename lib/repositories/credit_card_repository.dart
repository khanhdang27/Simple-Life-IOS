import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:dio/dio.dart';

class CreditCardRepository extends Repository {
  Future<CreditCard?> getOne() async {
    Map response = await httpManager.get(url: '/credit-card/one');
    if (response['data'] != null) {
      return CreditCard(
        number: response['data']['number'].toString(),
        expMonth: response['data']['exp_month'].toString(),
        expYear: response['data']['exp_year'].toString().substring(2, 4),
        cvc: response['data']['cvc'].toString(),
      );
    }
    return null;
  }

  Future<CreditCard?> add({
    required String number,
    required String expMonth,
    required String expYear,
    required String cvc,
  }) async {
    FormData formData = FormData.fromMap({
      'number': number,
      'exp_month': expMonth,
      'exp_year': expYear,
      'cvc': cvc,
    });
    Map response = await httpManager.post(
      url: '/credit-card/request',
      data: formData,
    );
    if (response['data'] != null) {
      return CreditCard(
        number: response['data']['number'].toString(),
        expMonth: response['data']['exp_month'].toString(),
        expYear: response['data']['exp_year'].toString().substring(2, 4),
        cvc: response['data']['cvc'].toString(),
      );
    }
    return null;
  }

  Future remove() async {
    Map response = await httpManager.get(url: '/credit-card/remove');
    return response['data'];
  }

  Future<CreditCard?> edit({
    required String expMonth,
    required String expYear,
  }) async {
    FormData formData = FormData.fromMap({
      'exp_month': expMonth,
      'exp_year': expYear,
    });
    Map response = await httpManager.post(
      url: '/credit-card/request',
      data: formData,
    );
    if (response['data'] != null) {
      return CreditCard(
        number: response['data']['number'].toString(),
        expMonth: response['data']['exp_month'].toString(),
        expYear: response['data']['exp_year'].toString().substring(2, 4),
        cvc: response['data']['cvc'].toString(),
      );
    }
    return null;
  }
}
