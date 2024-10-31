// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:dio/src/dio.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/router_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../core/interfaces/i_api_service.dart';
import '../core/interfaces/i_database_service.dart';
import '../core/repository/app_repository.dart';
import '../core/repository/event_repository.dart';
import '../core/services/api_service.dart';
import '../core/services/connection_service.dart';
import '../core/services/database_service.dart';
import '../core/services/dio_service.dart';
import '../core/services/objectbox_service.dart';
import '../core/services/order_service.dart';
import '../core/services/payment_service.dart';
import '../core/services/stripe_service.dart';
import 'app.router.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
  StackedRouterWeb? stackedRouter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => RouterService());
  locator.registerLazySingleton(() => PaymentService());
  locator.registerLazySingleton<IApiService>(() => ApiService());
  locator.registerLazySingleton<IDatabaseService>(() => DatabaseService());
  final objectboxService = ObjectboxService();
  await objectboxService.init();
  locator.registerSingleton(objectboxService);

  locator.registerLazySingleton<Dio>(() => DioService.init());
  locator.registerLazySingleton<Repository<Event>>(() => EventRepository());
  locator.registerLazySingleton(() => OrderService());
  locator.registerLazySingleton(() => StripeService());
  locator.registerLazySingleton(() => ConnectionService());
  if (stackedRouter == null) {
    throw Exception(
        'Stacked is building to use the Router (Navigator 2.0) navigation but no stackedRouter is supplied. Pass the stackedRouter to the setupLocator function in main.dart');
  }

  locator<RouterService>().setRouter(stackedRouter);
}
