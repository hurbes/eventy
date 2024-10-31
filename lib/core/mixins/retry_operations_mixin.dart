import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/services/connection_service.dart';

mixin RetryOperationsMixin {
  final _connectionService = locator<ConnectionService>();

  Future<T> trackApiOperation<T>(Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return result;
    } catch (e) {
      // Register the callback for retry when connection is restored
      _connectionService.registerCallback(() => apiCall());
      rethrow;
    }
  }
}
