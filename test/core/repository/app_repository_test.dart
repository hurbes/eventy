import 'package:eventy/core/exceptions/api_exceptions.dart';
import 'package:eventy/core/models/data_state/data_set.dart';
import 'package:eventy/core/repository/app_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/test_helpers.mocks.dart';
import 'package:eventy/app/app.locator.dart';

// Test Model
class TestModel {
  final int id;
  final String name;

  TestModel({required this.id, required this.name});

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

// Test Repository Implementation
class TestRepository extends Repository<TestModel> {
  // Add ValueNotifier for state management
  final ValueNotifier<DataState<List<TestModel>>> _listState =
      ValueNotifier(DataState.localLoading());
  final ValueNotifier<DataState<TestModel>> _singleState =
      ValueNotifier(DataState.localLoading());

  // Expose state streams
  ValueNotifier<DataState<List<TestModel>>> get listState => _listState;
  ValueNotifier<DataState<TestModel>> get singleState => _singleState;

  @override
  void emitListState(DataState<List<TestModel>> state) {
    _listState.value = state;
  }

  @override
  void emitSingleState(DataState<TestModel> state) {
    _singleState.value = state;
  }

  @override
  TestModel parseItem(Map<String, dynamic> json) => TestModel.fromJson(json);

  @override
  List<TestModel> parseList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => TestModel.fromJson(json)).toList();
  }

  @override
  String getItemId(TestModel item) => item.id.toString();

  @override
  bool get enableLogs => true;

  @override
  void dispose() {
    _listState.dispose();
    _singleState.dispose();
    super.dispose();
  }
}

void main() {
  TestRepository? repository;
  late MockApiService mockApiService;
  late MockDatabaseService mockDatabaseService;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerServices();
    mockApiService = getAndRegisterApiService();
    mockDatabaseService = getAndRegisterDatabaseService();
    repository = TestRepository();
  });

  tearDown(() async {
    repository?.dispose();
    await locator.reset();
  });

  group('AppRepository - Fetch All', () {
    final testData = [
      {'id': 1, 'name': 'Test 1'},
      {'id': 2, 'name': 'Test 2'},
    ];

    test('should fetch data from API successfully', () async {
      // Arrange
      when(mockApiService.get<Map<String, dynamic>>(
        endpoint: '/test',
        queryParameters: null,
      )).thenAnswer((_) async => {'data': testData});

      // Act
      await repository!.fetchAll(endpoint: '/test');

      // Assert
      verify(mockApiService.get<Map<String, dynamic>>(
        endpoint: '/test',
        queryParameters: null,
      )).called(1);

      expect(repository!.listState.value.status, equals(DataStatus.success));
      expect(repository!.listState.value.data?.length, equals(2));
      expect(repository!.listState.value.dataSource, equals(DataSource.api));
    });

    test('should handle API error gracefully', () async {
      // Arrange
      when(mockApiService.get<Map<String, dynamic>>(
        endpoint: '/test',
        queryParameters: null,
      )).thenThrow(ApiException('API Error'));

      // Act
      await repository!.fetchAll(endpoint: '/test');

      // Assert
      expect(repository!.listState.value.status, equals(DataStatus.error));
      expect(repository!.listState.value.errorMessage,
          contains('Failed to fetch data'));
    });

    test('should handle pagination correctly', () async {
      // Arrange
      final paginatedResponse = {
        'data': testData,
        'meta': {
          'current_page': 1,
          'from': 1,
          'last_page': 2,
          'per_page': 10,
          'to': 10,
          'total': 20,
          'links': [],
          'path': '/test',
          'allowed_filter_fields': [],
          'allowed_sorts': {
            'created_at': {'asc': 'asc', 'desc': 'desc'}
          },
          'default_sort': 'created_at',
          'default_sort_direction': 'desc'
        }
      };

      when(mockApiService.get<Map<String, dynamic>>(
        endpoint: '/test',
        queryParameters: {
          'page': 1,
          'per_page': 10,
        },
      )).thenAnswer((_) async => paginatedResponse);

      // Setup database mock
      when(mockDatabaseService.fetchAll<TestModel>())
          .thenAnswer((_) async => <TestModel>[]);
      when(mockDatabaseService.add(any)).thenAnswer((_) async {});

      // Act
      await repository!.fetchAll(
        endpoint: '/test',
        paginatedOptions: const PaginatedOption(
          isEnabled: true,
          page: 1,
          perPage: 10,
        ),
      );

      // Assert
      expect(repository!.listState.value.status, equals(DataStatus.success));
      expect(repository!.listState.value.pagination?.totalPages, equals(2));
      expect(repository!.listState.value.pagination?.page, equals(1));
      expect(repository!.listState.value.data?.length, equals(2));
    });
  });

  group('AppRepository - Fetch By ID', () {
    final testItem = {'id': 1, 'name': 'Test 1'};

    test('should fetch single item successfully', () async {
      // Arrange
      when(mockApiService.get<Map<String, dynamic>>(
        endpoint: '/test/1',
        queryParameters: null,
      )).thenAnswer((_) async => {'data': testItem});

      // Act
      await repository!.fetchById(id: '1', endpoint: '/test');

      // Assert
      expect(repository!.singleState.value.status, equals(DataStatus.success));
      expect(
        (repository!.singleState.value.data as TestModel).id,
        equals(testItem['id']),
      );
    });

    test('should handle single item fetch error', () async {
      // Arrange
      when(mockApiService.get<Map<String, dynamic>>(
        endpoint: '/test/1',
        queryParameters: null,
      )).thenThrow(ApiException('Not Found'));

      // Act
      await repository!.fetchById(id: '1', endpoint: '/test');

      // Assert
      expect(repository!.singleState.value.status, equals(DataStatus.error));
      expect(
        repository!.singleState.value.errorMessage,
        contains('API fetch by ID failed'),
      );
    });
  });

  group('AppRepository - Update', () {
    final testModel = TestModel(id: 1, name: 'Test 1');
    final updateBody = {'name': 'Updated Test 1'};

    test('should update item successfully', () async {
      // Arrange
      when(mockApiService.post<Map<String, dynamic>>(
        endpoint: '/test/1',
        data: updateBody,
      )).thenAnswer((_) async => {
            'data': {'id': 1, 'name': 'Updated Test 1'}
          });

      // Act
      await repository!.update(
        item: testModel,
        endpoint: '/test/1',
        body: updateBody,
      );

      // Assert
      verify(mockApiService.post<Map<String, dynamic>>(
        endpoint: '/test/1',
        data: updateBody,
      )).called(1);
    });

    test('should handle update error', () async {
      // Arrange
      when(mockApiService.post<Map<String, dynamic>>(
        endpoint: '/test/1',
        data: updateBody,
      )).thenThrow(ApiException('Update Failed'));

      // Act & Assert
      expect(
        () => repository!.update(
          item: testModel,
          endpoint: '/test/1',
          body: updateBody,
        ),
        throwsA(isA<ApiException>()),
      );
    });
  });

  group('AppRepository - Delete', () {
    test('should delete item successfully', () async {
      // Arrange
      when(mockApiService.delete<Map<String, dynamic>>(
        endpoint: '/test/1',
        queryParameters: null,
      )).thenAnswer((_) async => {'success': true});

      // Act
      await repository!.delete(id: 1, endpoint: '/test');

      // Assert
      verify(mockApiService.delete<Map<String, dynamic>>(
        endpoint: '/test/1',
        queryParameters: null,
      )).called(1);
    });

    test('should handle delete error', () async {
      // Arrange
      when(mockApiService.delete<Map<String, dynamic>>(
        endpoint: '/test/1',
        queryParameters: null,
      )).thenThrow(ApiException('Delete Failed'));

      // Act & Assert
      expect(
        () => repository!.delete(id: 1, endpoint: '/test'),
        throwsA(isA<ApiException>()),
      );
    });
  });

  group('AppRepository - Cache Management', () {
    test('should cache fetched data', () async {
      // Arrange
      final testData = [
        {'id': 1, 'name': 'Test 1'},
        {'id': 2, 'name': 'Test 2'},
      ];

      when(mockApiService.get<Map<String, dynamic>>(
        endpoint: '/test',
        queryParameters: null,
      )).thenAnswer((_) async => {'data': testData});

      // Act
      await repository!.fetchAll(endpoint: '/test');
      final cachedData = repository!.getCachedData('/test');

      // Assert
      expect(cachedData, isNotNull);
      expect(cachedData?.items.length, equals(2));
    });

    test('should clear cache on delete', () async {
      // Arrange
      when(mockApiService.delete<Map<String, dynamic>>(
        endpoint: '/test/1',
        queryParameters: null,
      )).thenAnswer((_) async => {'success': true});

      // Act
      await repository!.delete(id: 1, endpoint: '/test');
      final cachedData = repository!.getCachedData('/test');

      // Assert
      expect(cachedData, isNull);
    });
  });

  group('AppRepository - Database Operations', () {
    test('should clear database on delete', () async {
      // Arrange
      when(mockApiService.delete<Map<String, dynamic>>(
        endpoint: '/test/1',
        queryParameters: null,
      )).thenAnswer((_) async => {'success': true});

      // Setup database mock
      when(mockDatabaseService.delete(any)).thenAnswer((_) async {});

      // Reset any previous interactions
      clearInteractions(mockDatabaseService);

      // Act
      await repository!.delete(id: 1, endpoint: '/test');

      // Assert
      verify(mockDatabaseService.delete(1)).called(1);
    });
  });
}
