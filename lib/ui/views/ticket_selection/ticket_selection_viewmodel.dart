import 'package:eventy/app/app.locator.dart';
import 'package:eventy/app/app.router.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/core/services/order_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TicketSelectionViewModel extends ReactiveViewModel with AppLogger {
  final _orderService = locator<OrderService>();
  final _routerService = locator<RouterService>();

  Event? get event => _orderService.activeEvent;

  List<Ticket> get tickets => event?.tickets ?? [];

  Map<Ticket, int> get selectedTickets => _orderService.selectedTickets;

  bool get hasSelectedTickets {
    return selectedTickets.isNotEmpty &&
        selectedTickets.values.any((e) => e > 0);
  }

  int quantityForTicket(Ticket ticket) =>
      _orderService.quantityForTicket(ticket);

  bool canAddMoreTickets(Ticket ticket) =>
      _orderService.canAddMoreTickets(ticket);
  bool canRemoveTickets(Ticket ticket) =>
      _orderService.canRemoveTickets(ticket);

  void addTicket(Ticket ticket) => _orderService.addTicket(ticket);
  void removeTicket(Ticket ticket) => _orderService.removeTicket(ticket);

  void navigateToDetailsForm() {
    if (!hasSelectedTickets) {
      logI('Cannot navigate to details form, no tickets selected');
      return;
    }
    logI('Navigating to details form');
    _routerService.navigateToDetailsFormView();
  }

  String get eventImage {
    if (event?.images.isEmpty == true) return '';
    return event!.images.first.url;
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_orderService];

  @override
  bool get enableLogs => true;
}
