import 'dart:io';

import 'package:baseproject/blocs/app_bloc.dart';
import 'package:baseproject/blocs/auth/auth_bloc.dart';
import 'package:baseproject/configs/configs.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class HTTPManager {
  BaseOptions baseOptions = BaseOptions(
    baseUrl: AppConfig.baseApiUrl,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    responseType: ResponseType.json,
  );

  BaseOptions exportOption() {
    String? token;
    AuthState authState = AppBloc.authBloc.state;
    if (authState is AuthSuccess) {
      token = authState.user.token;
    }
    final Map<String, dynamic> header = {};
    baseOptions.headers.addAll(header);

    if (token != null) {
      baseOptions.headers["Authorization"] = 'Bearer ' + token;
    }
    return baseOptions;
  }

  Future<dynamic> post({
    required String url,
    data,
    Options? options,
  }) async {
    Dio dio = generateDio();
    try {
      final response = await dio.post(
        url,
        data: data,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      Response? response = error.response;
      if (response != null) {
        if (response.statusCode == 401) {
          AppBloc.authBloc.add(AuthLogout());
        }
      } else {
        AppBloc.authBloc.add(AuthLogout());
      }
      throw error;
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    Dio dio = generateDio();
    try {
      final response = await dio.get(
        url,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      Response? response = error.response;
      if (response != null) {
        if (response.statusCode == 401) {
          AppBloc.authBloc.add(AuthLogout());
        }
      } else {
        AppBloc.authBloc.add(AuthLogout());
      }
    } catch (_) {}
  }

  Dio generateDio() {
    Dio dio = new Dio(exportOption());
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    };
    return dio;
  }

  //Singleton
  factory HTTPManager() {
    return HTTPManager._internal();
  }

  HTTPManager._internal();
}
