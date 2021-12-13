import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:dio/dio.dart';

class UserRepository extends Repository {
  Future<Map> signUp({name, email, phone, password, confirm}) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'confirm_password': confirm,
    });
    Map response = await httpManager.post(
      url: '/site/signup',
      data: formData,
    );
    if (response['data']['status'] != 200) {
      return {
        'status': response['data']['status'],
        'errors': response['data']['errors'],
      };
    }
    return {'status': 200, 'errors': null};
  }

  Future<User> profile() async {
    Map response = await httpManager.post(url: '/profile/get');
    Map responseRaw = response['data'];
    User user = User.fromJson(responseRaw);
    return user;
  }

  Future<Map> addressRequest(String address) async {
    FormData formData = FormData.fromMap({'address': address});
    Map response = await httpManager.post(
      url: '/profile/address',
      data: formData,
    );
    if (response['data'] != null) {
      if (response['data']['status'] != 200) {
        return {
          'status': response['data']['status'],
          'errors': response['data']['errors'],
        };
      }
    }
    return {'status': 200, 'errors': null};
  }

  Future<Map> changePassword({oldPass, newPass, confirmPass}) async {
    FormData formData = FormData.fromMap({
      'old_password': oldPass,
      'password': newPass,
      'confirm_password': confirmPass,
    });
    Map response = await httpManager.post(
      url: '/profile/change-password',
      data: formData,
    );
    if (response['data']['status'] != 200) {
      return {
        'status': response['data']['status'],
        'errors': response['data']['errors'],
      };
    }
    return {'status': 200, 'errors': null};
  }

  Future<Map> updateProfile({phone, name}) async {
    FormData formData = FormData.fromMap({
      'phone': phone,
      'name': name,
    });
    Map response = await httpManager.post(
      url: '/profile/update-profile',
      data: formData,
    );
    if (response['data']['status'] != 200) {
      return {
        'status': response['data']['status'],
        'errors': response['data']['errors'],
      };
    }
    return {'status': 200, 'errors': null};
  }
}
