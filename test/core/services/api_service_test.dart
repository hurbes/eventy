import 'package:dio/dio.dart';
import 'package:eventy/core/exceptions/app_exceptions.dart';
import 'package:eventy/core/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eventy/app/app.locator.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.dart';

void main() {
  group('ApiServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });

  group('ApiService', () {
    test('GET request succeeds', () async {
      final mockDio = getAndRegisterDio();
      final apiService = ApiService();

      final responseData = {'key': 'value'};
      final response = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/test'),
      );

      when(mockDio.get('/test',
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options')))
          .thenAnswer((_) async => response);

      final result = await apiService.get(endpoint: '/test');
      expect(result, responseData);
      verify(mockDio.get('/test',
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options')))
          .called(1);
    });

    test('POST request succeeds', () async {
      final mockDio = getAndRegisterDio();
      final apiService = ApiService();

      final responseData = {'success': true};
      final response = Response(
        data: responseData,
        statusCode: 201,
        requestOptions: RequestOptions(path: '/test'),
      );

      when(mockDio.post(any,
              data: anyNamed('data'), options: anyNamed('options')))
          .thenAnswer((_) async => response);

      final result =
          await apiService.post(endpoint: '/test', data: {'name': 'test'});
      expect(result, responseData);
      verify(mockDio.post('/test',
              data: anyNamed('data'), options: anyNamed('options')))
          .called(1);
    });

    test('PUT request succeeds', () async {
      final mockDio = getAndRegisterDio();
      final apiService = ApiService();

      final responseData = {'updated': true};
      final response = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/test'),
      );

      when(mockDio.put(any,
              data: anyNamed('data'), options: anyNamed('options')))
          .thenAnswer((_) async => response);

      final result =
          await apiService.put(endpoint: '/test', data: {'name': 'update'});
      expect(result, responseData);
      verify(mockDio.put('/test',
              data: anyNamed('data'), options: anyNamed('options')))
          .called(1);
    });

    test('DELETE request succeeds', () async {
      final mockDio = getAndRegisterDio();
      final apiService = ApiService();

      final responseData = {'deleted': true};
      final response = Response(
        data: responseData,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/test'),
      );

      when(mockDio.delete(any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options')))
          .thenAnswer((_) async => response);

      final result = await apiService.delete(endpoint: '/test');
      expect(result, responseData);
      verify(mockDio.delete('/test',
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options')))
          .called(1);
    });

    test('Network error triggers retry and then throws NetworkException',
        () async {
      final mockDio = getAndRegisterDio();
      final apiService = ApiService();

      when(mockDio.get('/test',
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options')))
          .thenThrow(DioException(
              requestOptions: RequestOptions(path: '/test'),
              type: DioExceptionType.connectionTimeout));

      expect(() async => await apiService.get(endpoint: '/test'),
          throwsA(isA<NetworkException>()));
      verify(mockDio.get('/test',
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options')))
          .called(1);
    });

    test('Timeout throws NetworkException', () async {
      final mockDio = getAndRegisterDio();
      final apiService = ApiService();

      when(mockDio.get(any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options')))
          .thenThrow(DioException(
              requestOptions: RequestOptions(path: '/test'),
              type: DioExceptionType.connectionTimeout));

      expect(() async => await apiService.get(endpoint: '/test'),
          throwsA(isA<NetworkException>()));
    });

    test('API response error throws ApiException with correct status code',
        () async {
      final mockDio = getAndRegisterDio();
      final apiService = ApiService();

      when(mockDio.get(any,
              queryParameters: anyNamed('queryParameters'),
              options: anyNamed('options')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          statusCode: 500,
          requestOptions: RequestOptions(path: '/test'),
        ),
        type: DioExceptionType.badResponse,
      ));

      expect(() async => await apiService.get(endpoint: '/test'),
          throwsA(isA<ApiException>()));
    });
  });
}
