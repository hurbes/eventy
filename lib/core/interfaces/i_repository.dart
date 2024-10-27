import 'dart:async';

import 'package:eventy/core/models/data_state/data_set.dart';

abstract class IRepository<T> {
  // Core functions for repository

  Stream<DataState<List<T>>> get dataStream;

  Future<void> fetchAll({
    PaginatedOption? paginatedOptions,
    required String endpoint,
    Map<String, dynamic>? queryParams,
    bool ignoreCache = false,
  });

  Stream<DataState<T>> fetchById({
    required String id,
    required String endpoint,
  });

  Future<void> update({
    required T item,
    required String endpoint,
    required Map<String, dynamic> body,
  });

  Future<void> delete({
    required int id,
    required String endpoint,
  });

  // Exposed API calls
  Future<Map<String, dynamic>> fetchApiData({
    required String endpoint,
    Map<String, dynamic>? queryParams,
  });

  Future<Map<String, dynamic>> postApiData({
    required String endpoint,
    required Map<String, dynamic> body,
  });

  Future<Map<String, dynamic>> deleteApiData({
    required String endpoint,
  });

  // Exposed database functions
  Future<void> saveToDatabase(T item);
  Future<T?> getFromDatabase(int id);
  Future<void> deleteFromDatabase(int id);
}
