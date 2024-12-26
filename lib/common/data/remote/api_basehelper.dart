import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


//todo :  make sure 401 doesnot change lang or theme

@Singleton()
class ApiBaseHelper {
  final String _baseUrl = 'https://www.trendapp.org/test-project/public/api';
  final Dio dio = Dio();

  ApiBaseHelper() {
    _initDio();
    _initInterceptors();
  }

  void _initDio() {
    dio.options = BaseOptions(
      baseUrl: _baseUrl,
      headers: _defaultHeaders,
      validateStatus: (_) => true,
      sendTimeout: const Duration(milliseconds: 30000),
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    );

  }
  void _initInterceptors() {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      enabled: kDebugMode,
    ));
  }

  void updateLocaleInHeaders(String locale) {
    _defaultHeaders['Accept-Language'] = locale;
    dio.options.headers = _defaultHeaders;
  }

  final Map<String, String> _defaultHeaders = {
    'Accept': 'application/json',
    'Accept-Language': 'en',
    'Content-Type': 'application/json',
  };

  Future<dynamic> get({required String url, }) async {
    return _handleRequest(() => dio.get(url));
  }

  Future<dynamic> put({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    return _handleRequest(() => dio.put(url, data: body));
  }

  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    final formData = FormData.fromMap(body ?? {});
    return _handleRequest(() => dio.post(url, data: formData));
  }

  Future<dynamic> postWithRaw({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    return _handleRequest(() => dio.post(url, data: body));
  }

  Future<dynamic> postWithImage({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    _setCustomTimeouts(
      const Duration(milliseconds: 30000),
    );
    final formData = FormData.fromMap(body);
    final response = await _handleRequest(() => dio.post(url, data: formData));
    _resetTimeouts();
    return response;
  }

  Future<dynamic> delete({required String url, }) async {
    return _handleRequest(() => dio.delete(url));
  }

  Future<dynamic> uploadImage({required String url, required File file}) async {
    final fileName = file.path.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });
    return _handleRequest(() => dio.post(url, data: formData));
  }

  Future<dynamic> _handleRequest(Future<Response> Function() request) async {
    try {
      final response = await request();
      return _returnResponse(response);
    } on DioException catch (e) {
      return _returnResponse(e.response);
    } on UnAuthorizedException catch (e) {
      throw ServerException(e.toString());
    } catch (_) {
      throw ServerException(tr('error'));
    }
  }

  dynamic _returnResponse(Response? response) {
    if (response == null) {
      throw ServerException(tr('error_no_internet'));
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
      case 422:
      case 403:
        throw ServerException(response.data['message']?.toString() ?? '');
      case 401:
        throw UnAuthorizedException(response.data['message']?.toString() ?? '');
      case 500:
      default:
        throw ServerException(tr('server_error'));
    }
  }


  void _setCustomTimeouts(Duration timeout) {
    dio.options.sendTimeout = timeout;
    dio.options.connectTimeout = timeout;
    dio.options.receiveTimeout = timeout;
  }

  void _resetTimeouts() {
    _setCustomTimeouts(const Duration(milliseconds: 8000));
  }
}



class BaseException implements Exception {
  final String? message;

  BaseException(this.message);

  @override
  String toString() => message ?? 'An error occurred.';
}

class ServerException implements Exception {
  final String message;
  final Map<String, dynamic>? errorMap;

  ServerException(
    this.message, {
    this.errorMap,
  });
}

class UnAuthorizedException extends BaseException {
  UnAuthorizedException(String super.message);
}
