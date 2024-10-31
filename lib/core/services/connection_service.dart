import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:stacked/stacked.dart';

typedef ConnectionCallback = Future<void> Function();

class ConnectionService with ListenableServiceMixin {
  final _connectivity = Connectivity();
  StreamSubscription? _subscription;

  final _hasConnection = ReactiveValue<bool>(true);
  bool get hasConnection => _hasConnection.value;

  ConnectionCallback? _lastCallback;

  ConnectionService() {
    listenToReactiveValues([_hasConnection]);
    _initializeConnectionListener();
  }

  void _initializeConnectionListener() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) async {
      final isConnected = results.any((result) =>
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile);

      _hasConnection.value = isConnected;

      if (isConnected && _lastCallback != null) {
        await _lastCallback!();
        _lastCallback = null;
      }
    });
  }

  void registerCallback(ConnectionCallback callback) {
    _lastCallback = callback;
  }

  void dispose() {
    _subscription?.cancel();
  }
}
