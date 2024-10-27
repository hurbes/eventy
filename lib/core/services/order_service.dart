import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:stacked/stacked.dart';

class OrderService with ListenableServiceMixin, AppLogger {
  final _activeEvent = ReactiveValue<Event?>(null);
  final Map<Ticket, int> _selectedTickets = {};

  Map<Ticket, int> get selectedTickets => _selectedTickets;
  Event? get activeEvent => _activeEvent.value;

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
}
