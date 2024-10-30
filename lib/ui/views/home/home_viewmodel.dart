import 'dart:math';

import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:eventy/core/models/data_state/data_set.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/core/repository/app_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:eventy/app/app.router.dart';

class HomeViewModel extends StreamViewModel<DataState<List<Event>>>
    with IndexTrackingStateHelper, AppLogger {
  final _eventRepository = locator<Repository<Event>>();
  final _navigationService = locator<RouterService>();

  bool _hasMoreRecommendations = true;
  bool get hasMoreRecommendations => _hasMoreRecommendations;

  List<Event> get upcomingEvents {
    if (data?.data == null || data!.data!.isEmpty) return [];
    int count = min((data!.data!.length * 0.4).ceil(), 4);
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
  bool get isBusy {
    if (data == null) return true;
    return data!.status == DataStatus.loading && data!.data == null;
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

  @override
  void onError(error) {
    logE('Error in HomeViewModel: $error');
    super.onError(error);
  }

  @override
  bool get enableLogs => true;

  void navigateToEventDetails(Event event) {
    _navigationService.navigateToEventDetailsView(
      event: event,
    );
  }
}
