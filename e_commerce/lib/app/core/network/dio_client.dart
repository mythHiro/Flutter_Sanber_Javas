import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'dio_exception.dart';

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio();
    _configureOptions();

    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          logPrint: (object) => debugPrint('[DIO CLIENT] $object'),
        ),
      );
    }
  }

  void _configureOptions() {
    _dio.options
      ..baseUrl = 'https://dummyjson.com'
      ..connectTimeout = const Duration(seconds: 15)
      ..receiveTimeout = const Duration(seconds: 15)
      ..sendTimeout = const Duration(seconds: 15)
      ..headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
