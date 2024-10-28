import 'package:eventy/core/models/event/event.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/models/data_state/data_set.dart';

import 'package:eventy/ui/views/home/home_viewmodel.dart';
import 'package:mockito/mockito.dart';

import '../data/event_data.dart';
import '../helpers/test_helpers.dart';
import '../helpers/test_helpers.mocks.dart';

void main() {
  late HomeViewModel viewModel;
  late MockRepository mockEventRepository;

  setUp(() async {
    registerServices();
    mockEventRepository = getAndRegisterEventRepository();

    // Setup mock stream
    when(mockEventRepository.dataStream)
        .thenAnswer((_) => Stream.value(DataState.success([], DataSource.api)));

    // Setup default mock responses
    when(mockEventRepository.fetchAll(
      endpoint: anyNamed('endpoint'),
      paginatedOptions: anyNamed('paginatedOptions'),
      queryParams: anyNamed('queryParams'),
      ignoreCache: anyNamed('ignoreCache'),
    )).thenAnswer((_) async {});

    viewModel = HomeViewModel();
  });

  tearDown(() => locator.reset());

  group('HomeViewModel - Initialization', () {
    test('should initialize with empty data', () {
      expect(viewModel.upcomingEvents, isEmpty);
      expect(viewModel.popularEvent, isNull);
      expect(viewModel.recommendedEvents, isEmpty);
      expect(viewModel.hasMoreRecommendations, isTrue);
    });

    group('HomeViewModel - Data Processing', () {
      test('should handle empty data', () async {
        // Arrange
        final DataState<List<Event>> dataState =
            DataState.success([], DataSource.api);

        // Setup stream with empty data
        when(mockEventRepository.dataStream)
            .thenAnswer((_) => Stream.value(dataState));

        // Act
        viewModel.initialise();

        // Assert
        expect(viewModel.upcomingEvents, isEmpty);
        expect(viewModel.popularEvent, isNull);
        expect(viewModel.recommendedEvents, isEmpty);
      });
    });

    group('HomeViewModel - Navigation', () {
      test('should navigate to event details', () async {
        // Act
        viewModel.navigateToEventDetails(testEvent);
      });
    });

    group('HomeViewModel - Data Sections', () {
      setUp(() {
        final events = List.generate(10, (i) => testEvent);
        final dataState = DataState.success(events, DataSource.api);
        when(mockEventRepository.dataStream)
            .thenAnswer((_) => Stream.value(dataState));
      });
    });
  });
}
