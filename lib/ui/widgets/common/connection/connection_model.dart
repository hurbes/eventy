import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/services/connection_service.dart';
import 'package:stacked/stacked.dart';

class ConnectionModel extends ReactiveViewModel {
  final _connectionService = locator<ConnectionService>();

  bool get isVisible => !_connectionService.hasConnection;

  @override
  List<ListenableServiceMixin> get listenableServices => [_connectionService];
}
