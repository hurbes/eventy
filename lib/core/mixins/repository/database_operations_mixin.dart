import 'package:meta/meta.dart';
import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/interfaces/i_database_service.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';

mixin DatabaseOperationsMixin<T> on AppLogger {
  final _databaseService = locator<IDatabaseService>();

  @protected
  Future<void> saveToDatabase(T item) => _databaseService.update(item);

  @protected
  Future<T?> getFromDatabase(int id) => _databaseService.fetchById(id);

  @protected
  Future<void> deleteFromDatabase(int id) => _databaseService.delete(id);

  @protected
  Future<List<T>> getAllFromDatabase() => _databaseService.fetchAll<T>();

  @protected
  Future<void> clearDatabase() => _databaseService.clearAll<T>();
}
