import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class IApiService {
  @visibleForOverriding
  Dio get dio;

  Future<T> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<T> post<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  });

  Future<T> put<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  });

  Future<T> delete<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  // Logging and exception handling methods
  void logResponse(Response response);
  void logGenericException(String method, String endpoint, Object error);
  void handleException(DioError e);
}
