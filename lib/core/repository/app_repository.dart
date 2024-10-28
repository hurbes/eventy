import 'dart:async';

import 'package:eventy/core/exceptions/api_exceptions.dart';
import 'package:eventy/core/interfaces/i_repository.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:eventy/core/mixins/repository/api_operations_mixin.dart';
import 'package:eventy/core/mixins/repository/base_repository_mixin.dart';
import 'package:eventy/core/mixins/repository/database_operations_mixin.dart';
import 'package:eventy/core/mixins/repository/pagination_handler_mixin.dart';
import 'package:eventy/core/models/data_state/data_set.dart';
import 'package:flutter/foundation.dart';

abstract class Repository<T>
    with
        AppLogger,
        BaseRepositoryMixin<T>,
        ApiOperationsMixin,
        DatabaseOperationsMixin<T>,
        PaginationHandlerMixin<T>
    implements IRepository<T> {
  // Abstract methods to be implemented by specific repositories
  @protected
  T parseItem(Map<String, dynamic> json);

  @protected
  List<T> parseList(List<Map<String, dynamic>> jsonList);

  @protected
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
        await _handlePaginatedFetch(
          paginatedOptions: paginatedOptions!,
          endpoint: endpoint,
          queryParams: queryParams,
          ignoreCache: ignoreCache,
        );
      } else {
        await _handleSimpleFetch(
          endpoint: endpoint,
          queryParams: queryParams,
          ignoreCache: ignoreCache,
        );
      }
    } catch (e) {
      logE('Error in fetchAll: $e');
      emitListError(e);
    }
  }

  @protected
  Future<void> _handlePaginatedFetch({
    required PaginatedOption paginatedOptions,
    required String endpoint,
    Map<String, dynamic>? queryParams,
    bool ignoreCache = false,
  }) async {
    final cacheKey = buildCacheKey(endpoint, paginatedOptions.page);

    if (!ignoreCache) {
      await _handleLocalData(cacheKey, paginatedOptions);
    }

    await _handleApiData(
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

  @override
  Future<void> fetchById({
    required String id,
    required String endpoint,
  }) async {
    logI('Fetching by ID $id from $endpoint');
    emitSingleState(DataState.localLoading());

    T? data;
    // Try cache/database
    logI('Fetching from database');
    final dbData = await getFromDatabase(int.parse(id));
    if (dbData != null) {
      data = dbData;
      logI('Found in database');
      emitSingleState(DataState.success(dbData, DataSource.local));
    }

    logI('Fetching from API');
    emitSingleState(DataState.apiLoading(data: data));
    try {
      final response = await fetchApiData(endpoint: '$endpoint/$id');
      logI('Found in API ${response['data']}');

      final T item = parseItem(response['data']);
      await saveToDatabase(item);
      data = item;
      logI('Emitting success $data');
      emitSingleState(DataState.success(item, DataSource.api));
    } catch (e) {
      logE('API fetch by ID failed: $e');
      emitSingleState(DataState.error(
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
      await saveToDatabase(updatedItem);

      // Update cache if exists
      final cacheKey = endpoint;
      final existingCache = getCachedData(cacheKey);
      if (existingCache != null) {
        final updatedItems = _updateItemInList(
          existingCache.items,
          updatedItem,
        );
        await updateCache(
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
      await deleteFromDatabase(id);
      clearCache(); // Clear cache as the data set has changed
    } catch (e) {
      logE('Failed to delete item: $e');
      throw ApiException('Delete failed');
    }
  }

  // Private Helper Methods
  Future<void> _updateLocalStorage(
    String cacheKey,
    List<T> items, [
    PaginatedOption? pagination,
  ]) async {
    await updateCache(cacheKey, items, pagination);
    await clearDatabase();
    await Future.wait(items.map((item) => saveToDatabase(item)));
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

  @protected
  Future<void> _handleSimpleFetch({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    bool ignoreCache = false,
  }) async {
    final cacheKey = buildCacheKey(endpoint, null);

    if (!ignoreCache) {
      await _handleLocalData(cacheKey);
    }

    await _handleApiData(
      cacheKey: cacheKey,
      endpoint: endpoint,
      queryParams: queryParams,
    );
  }

  @protected
  Future<void> _handleLocalData(
    String cacheKey, [
    PaginatedOption? paginatedOptions,
  ]) async {
    emitListState(DataState.localLoading());

    final cachedData = getCachedData(cacheKey);
    if (cachedData == null) {
      final dbData = await getAllFromDatabase();
      if (dbData.isNotEmpty) {
        await updateCache(cacheKey, dbData, paginatedOptions);
        final updatedCachedData = getCachedData(cacheKey);
        if (updatedCachedData != null) {
          emitListState(_createSuccessState(updatedCachedData));
        }
      }
    } else {
      emitListState(_createSuccessState(cachedData));
    }
  }

  @protected
  Future<void> _handleApiData({
    required String cacheKey,
    required String endpoint,
    Map<String, dynamic>? queryParams,
    PaginatedOption? paginatedOptions,
  }) async {
    logI('Fetching API data from $endpoint');
    final currentData = getCachedData(cacheKey)?.items ?? [];
    emitListState(DataState.apiLoading(data: currentData));

    try {
      final apiResponse = await fetchApiData(
        endpoint: endpoint,
        queryParams: queryParams,
      );

      final newItems = _parseApiResponse(apiResponse);
      final updatedItems = appendNewItems(
        currentData,
        newItems,
        getItemId,
      );
      final updatedPagination = paginatedOptions != null
          ? extractPaginationFromResponse(apiResponse, paginatedOptions)
          : null;

      await _updateLocalStorage(cacheKey, updatedItems, updatedPagination);

      emitListState(DataState.success(
        updatedItems,
        DataSource.api,
        pagination: updatedPagination,
      ));
    } catch (e) {
      logE('API fetch failed: $e');
      emitListState(DataState.error(
        'Failed to fetch data',
        DataSource.api,
        currentData,
      ));
    }
  }
}
