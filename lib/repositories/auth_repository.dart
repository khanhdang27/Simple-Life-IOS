import 'package:baseproject/configs/configs.dart';
import 'package:baseproject/models/models.dart';
import 'package:baseproject/repositories/repositories.dart';
import 'package:dio/dio.dart';

class AuthRepository extends Repository {
  Future<dynamic> login(String username, String password) async {
    FormData formData = FormData.fromMap({
      'username': username,
      'password': password,
    });
    Map response = await httpManager.post(
      url: '/site/login',
      data: formData,
    );
    if (response['data']['status'] == 200) {
      return UserIdentity(
        id: response['data']['user']['id'],
        token: response['data']['token'],
      );
    }
    return response['data']['errors'];
  }

  Future<UserIdentity> loginExternal({
    required String id,
    required String email,
    String? name,
  }) async {
    FormData formData = FormData.fromMap({
      'email': email,
      'name': name,
    });
    Map response = await httpManager.post(
      url: '/site/login-external',
      data: formData,
    );
    AppSharedPrefs.setPhone(response['data']['phone'] ?? '');
    return UserIdentity(
      id: response['data']['user']['id'],
      token: response['data']['token'],
    );
  }
}
