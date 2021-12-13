import 'package:baseproject/repositories/repositories.dart';
import 'package:dio/dio.dart';

class ForgotPasswordRepository extends Repository {
  Future getCode({required String email}) async {
    FormData formData = FormData.fromMap({'email': email});
    Map response = await httpManager.post(
      url: '/site/reset-password-code',
      data: formData,
    );
    return response['data'];
  }

  Future resetPassword({
    required String email,
    required String code,
    required String password,
    required String confirm,
  }) async {
    FormData formData = FormData.fromMap({
      'email': email,
      'code': code,
      'password': password,
      'confirm_password': confirm,
    });
    Map response = await httpManager.post(
      url: '/site/reset-password',
      data: formData,
    );
    print("//======Hello=may=cung======//");
    print(response);
    print("//======END======//");
    return response['data'];
  }
}
