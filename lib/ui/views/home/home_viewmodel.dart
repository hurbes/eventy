import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:eventy/core/models/data_state/data_set.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/core/repository/app_repository.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends StreamViewModel<DataState<List<Event>>>
    with IndexTrackingStateHelper, AppLogger {
  final _eventRepository = locator<Repository<Event>>();

  bool _hasMoreRecommendations = true;
  bool get hasMoreRecommendations => _hasMoreRecommendations;

  List<Event> get upcomingEvents {
    if (data?.data == null || data!.data!.isEmpty) return [];
    int count = (data!.data!.length * 0.4).ceil();
    return data!.data!.take(count).toList();
  }

  Event? get popularEvent {
    if (data?.data == null || data!.data!.isEmpty) return null;
    int upcomingCount = upcomingEvents.length;
    if (data!.data!.length > upcomingCount) {
      return data!.data![upcomingCount];
    }
    return null;
  }

  List<Event> get recommendedEvents {
    if (data?.data == null || data!.data!.isEmpty) return [];
    int startIndex = upcomingEvents.length + (popularEvent != null ? 1 : 0);
    return data!.data!.sublist(startIndex);
  }

  @override
  Stream<DataState<List<Event>>> get stream => _eventRepository.dataStream;

  @override
  void initialise() {
    logI('HomeViewModel initialise called');
    super.initialise();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    logI('Fetching events');
    await _eventRepository.fetchAll(
      endpoint: '/events',
      paginatedOptions: const PaginatedOption(
        perPage: 10,
        page: 1,
        isEnabled: true,
      ),
    );
    logI('Events fetched, notifying listeners');
    notifyListeners();
  }

  Future<void> loadMoreRecommendations() async {
    if (!_hasMoreRecommendations || isBusy) return;

    try {
      await _eventRepository.fetchAll(
        endpoint: '/events',
        paginatedOptions: PaginatedOption(
          perPage: 10,
          page: (data?.pagination?.page ?? 1) + 1,
          isEnabled: true,
        ),
      );

      // Check if we've reached the last page
      _hasMoreRecommendations =
          data?.pagination?.page != data?.pagination?.totalPages;
    } catch (e) {
      logE('Error loading more recommendations: $e');
    }
  }

  @override
  void onData(DataState<List<Event>>? data) {
    logI('Received data in HomeViewModel: ${data?.data?.length} events');
    super.onData(data);
  }

  String getEventLocation(Event event) {
    return event.settings.target?.locationDetails.target?.venueName ?? '';
  }

  String getEventImage(Event event) {
    if (event.images.isEmpty) return '';
    return event.images.first.url;
  }

  String getEventDescription(Event event) {
    return event.description;
  }

  String getEventDate(Event event) {
    return event.startDate.toIso8601String();
  }

  @override
  void onError(error) {
    logE('Error in HomeViewModel: $error');
    super.onError(error);
  }

  @override
  bool get enableLogs => true;
}
