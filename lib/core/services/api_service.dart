import 'package:dio/dio.dart';
import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/exceptions/app_exceptions.dart';
import 'package:eventy/core/exceptions/base_exception.dart';
import 'package:eventy/core/interfaces/i_api_service.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:flutter/foundation.dart';

enum _RequestType { get, post, put, delete }

class ApiService extends IApiService with AppLogger {
  @visibleForTesting
  @override
  Dio get dio => locator<Dio>();

  // Private method for handling requests
  Future<T> _makeRequest<T>({
    required _RequestType requestType,
    required String endpoint,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    int retryCount = 1,
  }) async {
    try {
      Response<T> response;
      Options options = Options(headers: headers);

      // Retry mechanism
      int attempt = 0;
      do {
        try {
          switch (requestType) {
            case _RequestType.get:
              response = await dio.get<T>(endpoint,
                  queryParameters: queryParameters, options: options);
              break;
            case _RequestType.post:
              response =
                  await dio.post<T>(endpoint, data: data, options: options);
              break;
            case _RequestType.put:
              response =
                  await dio.put<T>(endpoint, data: data, options: options);
              break;
            case _RequestType.delete:
              response = await dio.delete<T>(endpoint,
                  queryParameters: queryParameters, options: options);
              break;
          }
          logResponse(response);
          return response.data!;
        } on DioException catch (e) {
          if (e.type == DioExceptionType.unknown && attempt < retryCount) {
            attempt++;
            logI("Retrying request... attempt $attempt");
            continue;
          }
          handleException(e);
          rethrow;
        }
      } while (attempt <= retryCount);
      throw Exception("Failed after $retryCount retries");
    } catch (e) {
      logGenericException(requestType.toString(), endpoint, e);
      rethrow;
    }
  }

  @override
  Future<T> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await _makeRequest<T>(
      requestType: _RequestType.get,
      endpoint: endpoint,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  @override
  Future<T> post<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    return await _makeRequest<T>(
      requestType: _RequestType.post,
      endpoint: endpoint,
      data: data,
      headers: headers,
    );
  }

  @override
  Future<T> put<T>({
    required String endpoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
  }) async {
    return await _makeRequest<T>(
      requestType: _RequestType.put,
      endpoint: endpoint,
      data: data,
      headers: headers,
    );
  }

  @override
  Future<T> delete<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await _makeRequest<T>(
      requestType: _RequestType.delete,
      endpoint: endpoint,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  @override
  void logResponse(Response response) {
    logD('''
    Response: 
    Status Code: ${response.statusCode}
    Data: ${response.data}
    Headers: ${response.headers}
    ''');
  }

  @override
  void logGenericException(String method, String endpoint, Object error) {
    logE('''
    Error during $method request to $endpoint:
    Error: $error
    ''');
  }

  @override
  void handleException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        logE('NetworkException: Connection timeout with message: ${e.message}');
        throw NetworkException('Connection timeout');

      case DioExceptionType.sendTimeout:
        logE('NetworkException: Send timeout with message: ${e.message}');
        throw NetworkException('Send timeout');

      case DioExceptionType.receiveTimeout:
        logE('NetworkException: Receive timeout with message: ${e.message}');
        throw NetworkException('Receive timeout');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        logE('ApiException: Status Code $statusCode, Message: ${e.message}');
        throw ApiException('API Error', statusCode);

      case DioExceptionType.cancel:
        logE('Request was cancelled');
        throw BaseException('Request was cancelled');

      default:
        logE('Unknown error with message: ${e.message}');
        throw BaseException('Unknown error');
    }
  }

  @override
  bool get enableLogs => true;
}
