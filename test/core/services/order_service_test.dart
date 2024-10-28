import 'package:flutter_test/flutter_test.dart';
import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/services/order_service.dart';
import 'package:mockito/mockito.dart';

import '../../data/event_data.dart';
import '../../data/ticket_data.dart';
import '../../data/order_data.dart';
import '../../helpers/test_helpers.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late OrderService orderService;
  late MockApiService mockApiService;

  setUp(() {
    registerServices();
    orderService = OrderService();
    mockApiService = getAndRegisterApiService();
  });

  tearDown(() => locator.reset());

  group('OrderService - Event Management', () {
    test('should set active event correctly', () {
      orderService.setActiveEvent(testEvent);
      expect(orderService.activeEvent, equals(testEvent));
    });

    test('should clear active event when setting null', () {
      orderService.setActiveEvent(null);
      expect(orderService.activeEvent, isNull);
    });
  });

  group('OrderService - Ticket Management', () {
    setUp(() {
      orderService.setActiveEvent(testEvent);
    });

    test('should return 0 for quantity of unselected ticket', () {
      expect(orderService.quantityForTicket(testTicket1), equals(0));
    });

    test('should add ticket correctly', () {
      orderService.addTicket(testTicket1);
      expect(orderService.quantityForTicket(testTicket1), equals(1));
    });

    test('should not exceed available quantity when adding tickets', () {
      final availableQuantity = testTicket1.prices.first.quantityRemaining;
      for (var i = 0; i < availableQuantity + 1; i++) {
        orderService.addTicket(testTicket1);
      }
      expect(orderService.quantityForTicket(testTicket1),
          equals(availableQuantity));
    });

    test('should remove ticket correctly', () {
      orderService.addTicket(testTicket1);
      orderService.removeTicket(testTicket1);
      expect(orderService.quantityForTicket(testTicket1), equals(0));
    });

    test('canAddMoreTickets should return correct value', () {
      expect(orderService.canAddMoreTickets(testTicket1), isTrue);

      final availableQuantity = testTicket1.prices.first.quantityRemaining;
      for (var i = 0; i < availableQuantity; i++) {
        orderService.addTicket(testTicket1);
      }

      expect(orderService.canAddMoreTickets(testTicket1), isFalse);
    });
  });

  group('OrderService - Order Creation', () {
    setUp(() {
      orderService.setActiveEvent(testEvent);
      orderService.addTicket(testTicket1);
    });

    test('should generate correct tickets payload', () {
      orderService.addTicket(testTicket1);

      final payload = orderService.getTicketsPayload();
      expect(payload['tickets'], isA<List>());
      expect(payload['tickets'].length, equals(1));
      expect(payload['tickets'][0]['ticket_id'], equals(testTicket1.id));
      expect(payload['tickets'][0]['quantities'][0]['quantity'], equals(2));
    });
  });

  group('OrderService - Payment Processing', () {
    setUp(() async {
      orderService.setActiveEvent(testEvent);
      orderService.addTicket(testTicket1);

      // Setup mock for createOrder
      when(mockApiService.post<Map<String, dynamic>>(
        endpoint: anyNamed('endpoint'),
        data: anyNamed('data'),
      )).thenAnswer((_) async => {'data': testOrder.toJson()});

      await orderService.createOrder();
    });
  });
}
