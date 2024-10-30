import 'package:meta/meta.dart';
import 'package:eventy/core/models/data_state/data_set.dart';
import 'package:eventy/core/utils/lru_cache.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';

mixin PaginationHandlerMixin<T> on AppLogger {
  final LRUCache<String, PaginatedData<T>> _cache = LRUCache(40);

  @protected
  PaginatedData<T>? getCachedData(String key) => _cache.get(key);

  @protected
  Future<void> updateCache(
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

  @protected
  String buildCacheKey(String endpoint, int? page) {
    return page != null ? '${endpoint}_$page' : endpoint;
  }

  @protected
  PaginatedOption extractPaginationFromResponse(
    Map<String, dynamic> response,
    PaginatedOption currentPagination,
  ) {
    final meta = response['meta'] as Map<String, dynamic>?;
    return currentPagination.copyWith(
      totalPages: meta?['last_page'] as int?,
      totalItems: meta?['total'] as int?,
    );
  }

  @protected
  List<T> appendNewItems(
    List<T> currentItems,
    List<T> newItems,
    int Function(T) getItemId,
  ) {
    final Set<int> currentIds = currentItems.map(getItemId).toSet();

    final Map<int, T> uniqueCurrentItems = Map.fromEntries(
        currentItems.map((item) => MapEntry(getItemId(item), item)));

    final List<T> uniqueNewItems = newItems
        .where((item) => !currentIds.contains(getItemId(item)))
        .toList();

    final Set<int> updatedItemsId = uniqueNewItems.map(getItemId).toSet();

    final Set<int> uniqueNewIds = newItems.map(getItemId).toSet();

    logI('New ids mixin $uniqueNewIds old $currentIds list $updatedItemsId');

    return [...uniqueCurrentItems.values, ...uniqueNewItems];
  }

  void clearCache() => _cache.clear();
}
