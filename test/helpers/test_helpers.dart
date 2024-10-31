import 'package:dio/dio.dart';
import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/interfaces/i_api_service.dart';
import 'package:eventy/core/interfaces/i_database_service.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/core/repository/app_repository.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:eventy/core/services/payment_service.dart';
import 'package:eventy/core/services/api_service.dart';

import 'test_helpers.mocks.dart';
import 'package:eventy/core/services/database_service.dart';
import 'package:eventy/core/services/objectbox_service.dart';
import 'package:eventy/core/services/dio_service.dart';
import 'package:eventy/core/services/order_service.dart';
import 'package:eventy/core/services/stripe_service.dart';
import 'package:eventy/core/services/connection_service.dart';
// @stacked-import

@GenerateMocks([], customMocks: [
  MockSpec<RouterService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<PaymentService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<Dio>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ApiService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DatabaseService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ObjectboxService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DioService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<OrderService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<Stripe>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<StripeService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<Repository<Event>>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ConnectionService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterPaymentService();
  getAndRegisterPaymentService();
  getAndRegisterDio();
  getAndRegisterApiService();
  getAndRegisterDatabaseService();
  getAndRegisterObjectboxService();
  getAndRegisterDioService();
  getAndRegisterOrderService();
  getAndRegisterStripeService();
  getAndRegisterConnectionService();
// @stacked-mock-register
}

MockRouterService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<RouterService>();
  final service = MockRouterService();

  locator.registerSingleton<RouterService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockPaymentService getAndRegisterPaymentService() {
  _removeRegistrationIfExists<PaymentService>();
  final service = MockPaymentService();
  locator.registerSingleton<PaymentService>(service);
  return service;
}

MockApiService getAndRegisterApiService() {
  _removeRegistrationIfExists<IApiService>();
  final service = MockApiService();
  locator.registerSingleton<IApiService>(service);
  return service;
}

MockDio getAndRegisterDio() {
  _removeRegistrationIfExists<Dio>();
  final service = MockDio();
  locator.registerSingleton<Dio>(service);
  return service;
}

MockDatabaseService getAndRegisterDatabaseService() {
  _removeRegistrationIfExists<IDatabaseService>();
  final service = MockDatabaseService();
  locator.registerSingleton<IDatabaseService>(service);
  return service;
}

MockObjectboxService getAndRegisterObjectboxService() {
  _removeRegistrationIfExists<ObjectboxService>();
  final service = MockObjectboxService();
  locator.registerSingleton<ObjectboxService>(service);
  return service;
}

MockDioService getAndRegisterDioService() {
  _removeRegistrationIfExists<DioService>();
  final service = MockDioService();
  locator.registerSingleton<DioService>(service);
  return service;
}

MockOrderService getAndRegisterOrderService() {
  _removeRegistrationIfExists<OrderService>();
  final service = MockOrderService();
  locator.registerSingleton<OrderService>(service);
  return service;
}

MockStripeService getAndRegisterStripeService() {
  _removeRegistrationIfExists<StripeService>();
  final service = MockStripeService();
  locator.registerSingleton<StripeService>(service);
  return service;
}

MockRepository getAndRegisterEventRepository() {
  _removeRegistrationIfExists<Repository<Event>>();
  final service = MockRepository();
  locator.registerSingleton<Repository<Event>>(service);
  return service;
}

MockConnectionService getAndRegisterConnectionService() {
  _removeRegistrationIfExists<ConnectionService>();
  final service = MockConnectionService();
  locator.registerSingleton<ConnectionService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
