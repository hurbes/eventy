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
    String Function(T) getItemId,
  ) {
    final Set<String> currentIds = currentItems.map(getItemId).toSet();
    final List<T> uniqueNewItems = newItems
        .where((item) => !currentIds.contains(getItemId(item)))
        .toList();
    return [...currentItems, ...uniqueNewItems];
  }

  void clearCache() => _cache.clear();
}
