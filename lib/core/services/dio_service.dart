import 'package:dio/dio.dart';

class DioService {
  static late final Dio _dio;

  static Dio init() {
    final options = BaseOptions(
      baseUrl: 'https://event.spark.love/api/public/',
      headers: {
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      validateStatus: (status) {
        return status != null && status >= 200 && status < 400;
      },
    );

    _dio = Dio(options);
    return _dio;
  }
}
