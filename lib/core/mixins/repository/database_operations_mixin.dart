import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/db/objectbox.g.dart';
import 'package:eventy/core/interfaces/i_database_service.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:flutter/foundation.dart';

mixin DatabaseOperationsMixin<T> on AppLogger {
  final _databaseService = locator<IDatabaseService>();

  FindAllHelper<T, Store>? get findAllHelper => null;

  @protected
  Future<void> saveToDatabase(T item) => _databaseService.update<T>(item);

  @protected
  Future<T?> getFromDatabase(int id) => _databaseService.fetchById<T>(id);

  @protected
  Future<void> deleteFromDatabase(int id) => _databaseService.delete(id);

  @protected
  Future<List<T>> getAllFromDatabase() {
    return _databaseService.fetchAll<T>(helper: findAllHelper);
  }

  @protected
  Future<void> clearDatabase() => _databaseService.clearAll<T>();
}
