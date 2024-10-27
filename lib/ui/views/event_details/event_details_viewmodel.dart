import 'package:eventy/app/app.locator.dart';
import 'package:eventy/app/app.router.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:eventy/core/models/data_state/data_set.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/core/repository/app_repository.dart';
import 'package:eventy/core/services/order_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EventDetailsViewModel extends StreamViewModel<DataState<Event>>
    with AppLogger {
  final Event _event;

  final _routerService = locator<RouterService>();
  final _orderService = locator<OrderService>();
  final _eventRepository = locator<Repository<Event>>();

  EventDetailsViewModel({required Event event}) : _event = event {
    logI('EventDetailsViewModel initialized ${event.id}');
  }

  Event get event => data?.data ?? _event;

  bool get isUpcoming {
    return event.startDate.isAfter(DateTime.now());
  }

  String get eventTitle {
    return event.title;
  }

  String get eventLocation {
    return event.settings.target?.locationDetails.target?.venueName ?? '';
  }

  String get eventImage {
    if (event.images.isEmpty) return '';
    return event.images.first.url;
  }

  String get eventDescription {
    return event.description;
  }

  String get eventDate {
    return event.startDate.toIso8601String();
  }

  String get eventOrganizer {
    return event.organizer.target?.name ?? '';
  }

  void navigateToTicketSelection() {
    _routerService.navigateToTicketSelectionView();
  }

  @override
  void onData(DataState<Event>? data) {
    logI('onData ${data?.data?.id}');
    _orderService.setActiveEvent(data?.data);
    super.onData(data);
  }

  @override
  Future<void> initialise() async {
    super.initialise();
    logI('Initialising EventDetailsViewModel ${event.id}');
    try {
      await _eventRepository.fetchById(
        id: event.id.toString(),
        endpoint: '/events',
      );
    } catch (e) {
      logE('Error fetching event details: $e');
    }
  }

  @override
  bool get enableLogs => true;

  @override
  Stream<DataState<Event>> get stream => _eventRepository.singleItemStream;
}
