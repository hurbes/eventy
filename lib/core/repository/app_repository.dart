import 'dart:async';

import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/exceptions/api_exceptions.dart';
import 'package:eventy/core/interfaces/i_api_service.dart';
import 'package:eventy/core/interfaces/i_repository.dart';
import 'package:eventy/core/interfaces/i_database_service.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:eventy/core/models/data_state/data_set.dart';
import 'package:eventy/core/utils/lru_cache.dart';

abstract class Repository<T> with AppLogger implements IRepository<T> {
  final apiService = locator<IApiService>();
  final databaseService = locator<IDatabaseService>();
  final LRUCache<String, PaginatedData<T>> _cache;

  final _dataStreamController =
      StreamController<DataState<List<T>>>.broadcast();

  final _singleItemStreamController =
      StreamController<DataState<T>>.broadcast();

  Repository() : _cache = LRUCache(40);

  @override
  Stream<DataState<List<T>>> get dataStream => _dataStreamController.stream;

  @override
  Stream<DataState<T>> get singleItemStream =>
      _singleItemStreamController.stream;

  // Abstract methods to be implemented by specific repositories
  T parseItem(Map<String, dynamic> json);
  List<T> parseList(List<Map<String, dynamic>> jsonList);
  String getItemId(T item);

  @override
  Future<void> fetchAll({
    PaginatedOption? paginatedOptions,
    required String endpoint,
    Map<String, dynamic>? queryParams,
    bool ignoreCache = false,
  }) async {
    logI('Fetching all data from $endpoint');
    try {
      if (paginatedOptions?.isEnabled ?? false) {
        await for (var state in _fetchPaginated(
          paginatedOptions: paginatedOptions!,
          endpoint: endpoint,
          queryParams: queryParams,
          ignoreCache: ignoreCache,
        )) {
          logI('Emitting state: $state');
          _dataStreamController.add(state);
        }
      } else {
        await for (var state in _fetchSimple(
          endpoint: endpoint,
          queryParams: queryParams,
          ignoreCache: ignoreCache,
        )) {
          logI('Emitting state: $state');
          _dataStreamController.add(state);
        }
      }
    } catch (e) {
      logE('Error in fetchAll: $e');
      _dataStreamController.addError(e);
    }
  }

  Stream<DataState<List<T>>> _fetchPaginated({
    required PaginatedOption paginatedOptions,
    required String endpoint,
    Map<String, dynamic>? queryParams,
    bool ignoreCache = false,
  }) async* {
    logI('Fetching paginated data from $endpoint');
    final cacheKey = _buildCacheKey(endpoint, paginatedOptions.page);

    if (!ignoreCache) {
      logI('Fetching local data from $cacheKey');
      yield* _handleLocalData(cacheKey, paginatedOptions);
    }

    logI('Fetching API data from $endpoint');
    yield* _handleApiData(
      cacheKey: cacheKey,
      endpoint: endpoint,
      queryParams: {
        'page': paginatedOptions.page,
        'per_page': paginatedOptions.perPage,
        ...?queryParams,
      },
      paginatedOptions: paginatedOptions,
    );
  }

  Stream<DataState<List<T>>> _fetchSimple({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    bool ignoreCache = false,
  }) async* {
    final cacheKey = endpoint;

    logI('Fetching local data from $cacheKey');
    if (!ignoreCache) {
      yield* _handleLocalData(cacheKey);
    }

    yield* _handleApiData(
      cacheKey: cacheKey,
      endpoint: endpoint,
      queryParams: queryParams,
    );
  }

  Stream<DataState<List<T>>> _handleLocalData(
    String cacheKey, [
    PaginatedOption? paginatedOptions,
  ]) async* {
    yield DataState.localLoading();

    final cachedData = _getCachedData(cacheKey);
    if (cachedData == null) {
      final dbData = await _getDataFromDatabase();
      if (dbData.isNotEmpty) {
        await _updateCache(cacheKey, dbData, paginatedOptions);
        final updatedCachedData = _getCachedData(cacheKey);
        if (updatedCachedData != null) {
          yield _createSuccessState(updatedCachedData);
        }
      }
    } else {
      yield _createSuccessState(cachedData);
    }
  }

  Stream<DataState<List<T>>> _handleApiData({
    required String cacheKey,
    required String endpoint,
    Map<String, dynamic>? queryParams,
    PaginatedOption? paginatedOptions,
  }) async* {
    logI('Fetching API data from $endpoint');
    final currentData = _getCachedData(cacheKey)?.items ?? [];
    yield DataState.apiLoading(data: currentData);

    try {
      logI('Fetching API data from $endpoint');

      final apiResponse = await fetchApiData(
        endpoint: endpoint,
        queryParams: queryParams,
      );

      final newItems = _parseApiResponse(apiResponse);
      final updatedItems = _appendNewItems(currentData, newItems);
      final updatedPagination = paginatedOptions != null
          ? _extractPaginationFromResponse(apiResponse, paginatedOptions)
          : null;

      logI('Updating local storage with $cacheKey');

      await _updateLocalStorage(cacheKey, updatedItems, updatedPagination);

      yield DataState.success(
        updatedItems,
        DataSource.api,
        pagination: updatedPagination,
      );
    } catch (e) {
      logE('API fetch failed: $e');
      yield DataState.error(
        'Failed to fetch data',
        DataSource.api,
        currentData,
      );
    }
  }

  // New helper method to append new items to the current data
  List<T> _appendNewItems(List<T> currentItems, List<T> newItems) {
    final Set<String> currentIds =
        currentItems.map((item) => getItemId(item)).toSet();
    final List<T> uniqueNewItems = newItems
        .where((item) => !currentIds.contains(getItemId(item)))
        .toList();
    return [...currentItems, ...uniqueNewItems];
  }

  @override
  Future<void> fetchById({
    required String id,
    required String endpoint,
  }) async {
    logI('Fetching by ID $id from $endpoint');
    _singleItemStreamController.add(DataState.localLoading());

    T? data;
    // Try cache/database
    logI('Fetching from database');
    final dbData = await databaseService.fetchById<T>(int.parse(id));
    if (dbData != null) {
      data = dbData;
      logI('Found in database');
      _singleItemStreamController
          .add(DataState.success(dbData, DataSource.local));
    }

    logI('Fetching from API');
    _singleItemStreamController.add(DataState.apiLoading());
    try {
      final response = await fetchApiData(endpoint: '$endpoint/$id');

      logI('Found in API ${response['data']}');

      final T item = parseItem(response);
      await _updateSingleItem(item);
      data = item;
      logI('Emitting success $data');
      _singleItemStreamController.add(DataState.success(item, DataSource.api));
      return;
    } catch (e) {
      logE('API fetch by ID failed: $e');
      _singleItemStreamController.add(DataState.error(
        'API fetch by ID failed: $e',
        DataSource.api,
        data,
      ));
    }
  }

  @override
  Future<void> update({
    required T item,
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    try {
      final apiResponse = await postApiData(endpoint: endpoint, body: body);
      final updatedItem =
          parseItem(apiResponse['data'] as Map<String, dynamic>);
      await _updateSingleItem(updatedItem);

      // Update cache if exists
      final cacheKey = endpoint;
      final existingCache = _getCachedData(cacheKey);
      if (existingCache != null) {
        final updatedItems = _updateItemInList(
          existingCache.items,
          updatedItem,
        );
        await _updateCache(
          cacheKey,
          updatedItems,
          existingCache.pagination,
        );
      }

      logD('Successfully updated item: ${getItemId(updatedItem)}');
    } catch (e) {
      logE('Failed to update item: $e');
      if (e is ApiException) rethrow;
      throw ApiException('Update failed: ${e.toString()}');
    }
  }

  @override
  Future<void> delete({
    required int id,
    required String endpoint,
  }) async {
    try {
      await deleteApiData(endpoint: '$endpoint/$id');
      await _deleteSingleItem(id);
      _cache.clear(); // Clear cache as the data set has changed
    } catch (e) {
      logE('Failed to delete item: $e');
      throw ApiException('Delete failed');
    }
  }

  // API Helper Methods
  @override
  Future<Map<String, dynamic>> fetchApiData({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      return await apiService.get(
        endpoint: endpoint,
        queryParameters: queryParams,
      );
    } catch (e) {
      throw ApiException('Failed to fetch data');
    }
  }

  @override
  Future<Map<String, dynamic>> postApiData({
    required String endpoint,
    required Map<String, dynamic> body,
  }) async {
    try {
      return await apiService.post(endpoint: endpoint, data: body);
    } catch (e) {
      throw ApiException('Failed to post data');
    }
  }

  @override
  Future<Map<String, dynamic>> deleteApiData({required String endpoint}) async {
    try {
      return await apiService.delete(endpoint: endpoint);
    } catch (e) {
      throw ApiException('Failed to delete data');
    }
  }

  // Database Helper Methods
  @override
  Future<void> saveToDatabase(T item) async => databaseService.update(item);

  @override
  Future<T?> getFromDatabase(int id) async => databaseService.fetchById(id);

  @override
  Future<void> deleteFromDatabase(int id) async => databaseService.delete(id);

  // Private Helper Methods
  Future<void> _updateLocalStorage(
    String cacheKey,
    List<T> items, [
    PaginatedOption? pagination,
  ]) async {
    await _updateCache(cacheKey, items, pagination);
    await _updateDatabase(items);
  }

  Future<void> _updateDatabase(List<T> items) async {
    await databaseService.clearAll<T>();
    await Future.wait(items.map((item) => saveToDatabase(item)));
  }

  Future<void> _updateSingleItem(T item) async {
    await saveToDatabase(item);
  }

  Future<void> _deleteSingleItem(int id) async {
    await deleteFromDatabase(id);
  }

  Future<List<T>> _getDataFromDatabase() async {
    return await databaseService.fetchAll<T>();
  }

  List<T> _updateItemInList(List<T> items, T updatedItem) {
    return items.map((item) {
      return getItemId(item) == getItemId(updatedItem) ? updatedItem : item;
    }).toList();
  }

  DataState<List<T>> _createSuccessState(PaginatedData<T> data) {
    return DataState.success(
      data.items,
      DataSource.local,
      pagination: data.pagination,
    );
  }

  String _buildCacheKey(String endpoint, int? page) {
    return page != null ? '${endpoint}_$page' : endpoint;
  }

  List<T> _parseApiResponse(Map<String, dynamic> response) {
    final parsed = (response['data'] as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();
    return parseList(parsed);
  }

  PaginatedOption _extractPaginationFromResponse(
    Map<String, dynamic> response,
    PaginatedOption currentPagination,
  ) {
    final meta = response['meta'] as Map<String, dynamic>?;
    return currentPagination.copyWith(
      totalPages: meta?['last_page'] as int?,
      totalItems: meta?['total'] as int?,
    );
  }

  PaginatedData<T>? _getCachedData(String key) => _cache.get(key);

  Future<void> _updateCache(
    String key,
    List<T> items, [
    PaginatedOption? pagination,
  ]) async {
    final paginatedData = PaginatedData(
      items: items,
      pagination: pagination ?? const PaginatedOption(),
    );
    _cache.put(key, paginatedData);
  }
}
