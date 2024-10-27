import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/interfaces/i_api_service.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/core/models/order/order.dart';
import 'package:stacked/stacked.dart';

import 'stripe_service.dart';

class OrderService with ListenableServiceMixin, AppLogger {
  final _activeEvent = ReactiveValue<Event?>(null);
  final Map<Ticket, int> _selectedTickets = {};
  final _order = ReactiveValue<Order?>(null);

  final _apiService = locator<IApiService>();
  final _stripeService = locator<StripeService>();

  Map<Ticket, int> get selectedTickets => _selectedTickets;
  Event? get activeEvent => _activeEvent.value;
  Order? get order => _order.value;

  void setActiveEvent(Event? event) {
    _activeEvent.value = event;
    logE('Active event set to: ${event?.tickets.length}');
  }

  int quantityForTicket(Ticket ticket) => _selectedTickets[ticket] ?? 0;

  void addTicket(Ticket ticket) {
    final currentQuantity = _selectedTickets[ticket] ?? 0;
    // Check if adding one more ticket would exceed the available quantity
    if (currentQuantity < ticket.prices.first.quantityRemaining) {
      _selectedTickets[ticket] = currentQuantity + 1;
      notifyListeners();
    }
  }

  void removeTicket(Ticket ticket) {
    final currentQuantity = _selectedTickets[ticket] ?? 0;
    // Check if we have tickets to remove and don't go below 0
    if (currentQuantity > 0) {
      _selectedTickets[ticket] = currentQuantity - 1;
      notifyListeners();
    }
  }

  bool canAddMoreTickets(Ticket ticket) {
    final currentQuantity = _selectedTickets[ticket] ?? 0;
    return currentQuantity < ticket.prices.first.quantityRemaining;
  }

  bool canRemoveTickets(Ticket ticket) {
    final currentQuantity = _selectedTickets[ticket] ?? 0;
    return currentQuantity > 0;
  }

  OrderService() {
    listenToReactiveValues([_activeEvent]);
  }

  @override
  bool get enableLogs => true;

  Map<String, dynamic> getTicketsPayload() {
    final ticketsList = _selectedTickets.entries
        .where((entry) =>
            entry.value > 0) // Only include tickets with quantity > 0
        .map((entry) => {
              'ticket_id': entry.key.id,
              'quantities': [
                {
                  'price_id': entry.key.prices.first.id,
                  'quantity': entry.value,
                }
              ]
            })
        .toList();

    return {
      'tickets': ticketsList,
    };
  }

  Future<void> createOrder() async {
    try {
      final payload = getTicketsPayload();
      logI('Creating order with payload: $payload');
      final response = await _apiService.post<Map<String, dynamic>>(
        endpoint: '/events/${_activeEvent.value?.id}/order',
        data: payload,
      );

      final order = Order.fromJson(response['data']);

      _order.value = order;
    } catch (e) {
      logE('Error creating order: $e');
    }
  }

  Future<void> completeOrder(Map<String, dynamic> data) async {
    final order = _order.value;

    logI(data);

    try {
      await _apiService.put<Map<String, dynamic>>(
        endpoint: '/events/${_activeEvent.value?.id}/order/${order?.shortId}',
        data: data,
      );
    } catch (e) {
      logE('Error creating payment: $e');
    }

    await createPayment();
  }

  Future<void> createPayment() async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        endpoint:
            '/events/${_activeEvent.value?.id}/order/${order?.shortId}/stripe/payment_intent',
        data: {},
      );

      final paymentIntent = PaymentIntent.fromJson(response);

      await _stripeService.createPayment(paymentIntent.clientSecret);
    } catch (e) {
      logE('Error creating payment: $e');
    }
  }
}
