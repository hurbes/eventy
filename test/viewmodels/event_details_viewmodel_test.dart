import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/models/data_state/data_set.dart';
import 'package:eventy/core/models/event/event.dart';
import 'package:eventy/core/repository/app_repository.dart';
import 'package:eventy/ui/views/event_details/event_details_viewmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:objectbox/objectbox.dart';

import '../data/event_data.dart';
import '../helpers/test_helpers.dart';
import '../helpers/test_helpers.mocks.dart';

// Create a proper mock for Repository<Event>
class MockEventRepository extends Mock implements Repository<Event> {
  final _singleItemController = StreamController<DataState<Event>>();

  @override
  Stream<DataState<Event>> get singleItemStream => _singleItemController.stream;

  void emitEvent(Event event) {
    _singleItemController.add(DataState.success(event, DataSource.api));
  }

  void emitError(String error) {
    _singleItemController.add(DataState.error(error, DataSource.api));
  }

  @override
  void dispose() {
    _singleItemController.close();
  }
}

void main() {
  late EventDetailsViewModel viewModel;
  late MockOrderService mockOrderService;
  late MockEventRepository mockEventRepository;

  setUp(() {
    registerServices();
    mockOrderService = getAndRegisterOrderService();
    mockEventRepository = MockEventRepository();

    // Register the mock repository
    locator.registerSingleton<Repository<Event>>(mockEventRepository);

    // Initialize viewModel with test event
    viewModel = EventDetailsViewModel(event: testEvent);
  });

  tearDown(() {
    mockEventRepository.dispose();
    locator.reset();
  });

  group('EventDetailsViewModel - Initialization', () {
    test('should initialize with provided event', () {
      expect(viewModel.event, equals(testEvent));
      expect(viewModel.eventTitle, equals(testEvent.title));
      expect(viewModel.eventImage, equals(testEvent.images.first.url));
    });

    test('should handle initialization of archived event', () {
      final archivedEvent = Event(
        id: 1,
        title: 'Archived Event',
        description: 'Description',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: 'ARCHIVED',
        lifecycleStatus: '',
        currency: '',
        timezone: '',
        slug: '',
        images: ToMany<EventImage>(),
        settings: ToOne<Settings>(),
        organizer: ToOne<Organizer>(),
        tickets: ToMany<Ticket>(),
      );

      final archivedViewModel = EventDetailsViewModel(event: archivedEvent);
      expect(archivedViewModel.isArchived, isTrue);
      expect(archivedViewModel.buttonText, equals('Event Ended'));
    });
  });

  group('EventDetailsViewModel - Event Status', () {
    test('should correctly identify archived events', () {
      final archivedEvent = Event(
        id: 1,
        title: 'Archived Event',
        description: 'Description',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: 'ARCHIVED',
        lifecycleStatus: '',
        currency: '',
        timezone: '',
        slug: '',
        images: ToMany<EventImage>(),
        settings: ToOne<Settings>(),
        organizer: ToOne<Organizer>(),
        tickets: ToMany<Ticket>(),
      );

      final vm = EventDetailsViewModel(event: archivedEvent);
      expect(vm.isArchived, isTrue);
      expect(vm.isBookable, isFalse);
    });

    test('should correctly identify upcoming events', () {
      final futureEvent = Event(
        id: 1,
        title: 'Future Event',
        description: 'Description',
        startDate: DateTime.now().add(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 2)),
        status: 'ACTIVE',
        lifecycleStatus: '',
        currency: '',
        timezone: '',
        slug: '',
        images: ToMany<EventImage>(),
        settings: ToOne<Settings>(),
        organizer: ToOne<Organizer>(),
        tickets: ToMany<Ticket>(),
      );

      final vm = EventDetailsViewModel(event: futureEvent);
      expect(vm.isUpcoming, isTrue);
    });

    test('should handle events with no tickets', () {
      final noTicketsEvent = Event(
        id: 1,
        title: 'No Tickets Event',
        description: 'Description',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: 'ACTIVE',
        lifecycleStatus: '',
        currency: '',
        timezone: '',
        slug: '',
        images: ToMany<EventImage>(),
        settings: ToOne<Settings>(),
        organizer: ToOne<Organizer>(),
        tickets: ToMany<Ticket>(),
      );

      final vm = EventDetailsViewModel(event: noTicketsEvent);
      expect(vm.isBookable, isFalse);
      expect(vm.buttonText, equals('Tickets Sold Out'));
    });
  });

  group('EventDetailsViewModel - Event Details', () {
    test('should return correct event details', () {
      expect(viewModel.eventTitle, equals(testEvent.title));
      expect(viewModel.eventDescription, equals(testEvent.description));
      expect(
          viewModel.eventDate, equals(testEvent.startDate.toIso8601String()));
      expect(
          viewModel.eventOrganizer, equals(testEvent.organizer.target?.name));
      expect(viewModel.eventLocation,
          equals(testEvent.settings.target?.locationDetails.target?.venueName));
    });

    test('should handle missing event details gracefully', () {
      final minimalEvent = Event(
        id: 1,
        title: 'Minimal Event',
        description: '',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: '',
        lifecycleStatus: '',
        currency: '',
        timezone: '',
        slug: '',
        images: ToMany<EventImage>(),
        settings: ToOne<Settings>(),
        organizer: ToOne<Organizer>(),
        tickets: ToMany<Ticket>(),
      );

      final vm = EventDetailsViewModel(event: minimalEvent);
      expect(vm.eventImage, isEmpty);
      expect(vm.eventOrganizer, isEmpty);
      expect(vm.eventLocation, isEmpty);
    });
  });

  group('EventDetailsViewModel - Data Stream', () {
    test('should update event data when stream emits new data', () async {
      // Arrange
      final updatedEvent = Event(
        id: testEvent.id,
        title: 'Updated Event',
        description: 'Updated Description',
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        status: '',
        lifecycleStatus: '',
        currency: '',
        timezone: '',
        slug: '',
        images: ToMany<EventImage>(),
        settings: ToOne<Settings>(),
        organizer: ToOne<Organizer>(),
        tickets: ToMany<Ticket>(),
      );

      // Act
      await viewModel.initialise();
      mockEventRepository.emitEvent(updatedEvent);

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert
      verify(mockOrderService.setActiveEvent(updatedEvent)).called(1);
    });
  });

  group('EventDetailsViewModel - Navigation', () {
    test('should navigate to ticket selection', () async {
      // Act
      viewModel.navigateToTicketSelection();
    });
  });
}
