import 'package:meta/meta.dart';
import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/exceptions/api_exceptions.dart';
import 'package:eventy/core/interfaces/i_api_service.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';

mixin ApiOperationsMixin on AppLogger {
  final _apiService = locator<IApiService>();

  @protected
  Future<Map<String, dynamic>> fetchApiData({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return await _apiService.get(
        endpoint: endpoint,
        queryParameters: queryParams,
      );
    } catch (e) {
      logE('API fetch failed: $e');
      throw ApiException('Failed to fetch data');
    }
  }

  @protected
  Future<Map<String, dynamic>> postApiData({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    try {
      return await _apiService.post(endpoint: endpoint, data: body);
    } catch (e) {
      logE('API post failed: $e');
      throw ApiException('Failed to post data');
    }
  }

  @protected
  Future<Map<String, dynamic>> deleteApiData({
    required String endpoint,
  }) async {
    try {
      return await _apiService.delete(endpoint: endpoint);
    } catch (e) {
      logE('API delete failed: $e');
      throw ApiException('Failed to delete data');
    }
  }
}
