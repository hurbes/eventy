import 'package:eventy/app/app.locator.dart';
import 'package:eventy/core/exceptions/database_exception.dart';
import 'package:eventy/core/interfaces/i_database_service.dart';
import 'package:eventy/core/mixins/logger_mixin.dart';
import 'package:eventy/core/services/objectbox_service.dart';
import 'package:objectbox/objectbox.dart';

class DatabaseService with AppLogger implements IDatabaseService {
  final _store = locator<ObjectboxService>().store;

  @override
  Future<void> add<T>(T object) async {
    try {
      final box = _store.box<T>();
      box.put(object);
      logD('Added object: $object');
    } catch (e) {
      logE('Error adding object: $e');
      throw AddException('Failed to add object: $e');
    }
  }

  @override
  Future<void> update<T>(T object) async {
    try {
      final box = _store.box<T>();
      box.put(object, mode: PutMode.insert);
      logD('Updated object: $object');
    } catch (e) {
      logE('Error updating object: $e');
      throw UpdateException('Failed to update object: $e');
    }
  }

  @override
  Future<void> delete<T>(T object) async {
    try {
      final box = _store.box<T>();

      // Safe way to access id using reflection
      final idProperty = (object as dynamic).id as int?;
      if (idProperty == null) {
        throw DeleteException('Object does not have a valid ID');
      }

      box.remove(idProperty);
      logD('Deleted object: $object');
    } catch (e) {
      logE('Error deleting object: $e');
      throw DeleteException('Failed to delete object: $e');
    }
  }

  @override
  Future<List<T>> fetchAll<T>() async {
    try {
      final box = _store.box<T>();
      final results = box.getAll();
      logD('Fetched all objects of type ${T.toString()}');
      return results;
    } catch (e) {
      logE('Error fetching all objects of type ${T.toString()}: $e');
      throw FetchException('Failed to fetch objects: $e');
    }
  }

  @override
  Future<T?> fetchById<T>(int id) async {
    try {
      final box = _store.box<T>();
      final result = box.get(id);
      logD('Fetched object by id $id: $result');
      return result;
    } catch (e) {
      logE('Error fetching object by id $id: $e');
      throw FetchException('Failed to fetch object by id: $e');
    }
  }

  @override
  Future<List<T>> query<T>(String query) async {
    try {
      final box = _store.box<T>();
      final results = box.query().build().find();
      logD('Executed query for type ${T.toString()}, Results: $results');
      return results;
    } catch (e) {
      logE('Error executing query for type ${T.toString()}: $e');
      throw QueryException('Failed to execute query: $e');
    }
  }

  @override
  Stream<List<T>> queryStream<T>(String query) {
    try {
      final box = _store.box<T>();
      final queryBuilder = box.query();
      logD('Query stream initialized for type ${T.toString()}');
      return queryBuilder.watch(triggerImmediately: true).map((q) => q.find());
    } catch (e) {
      logE('Error initializing query stream for type ${T.toString()}: $e');
      throw QueryException('Failed to initialize query stream: $e');
    }
  }

  @override
  Future<void> clearAll<T>() async {
    try {
      final box = _store.box<T>();
      await box.removeAllAsync();

      logD('Clearing all the data ${T.toString()}');
    } catch (e) {
      logE('Failed to remove data ${T.toString()}: $e');
      throw QueryException('Failed to remove data: $e');
    }
  }

  // Dispose method to clean up resources
  void dispose() {
    _store.close();
    logI('Database service disposed.');
  }

  @override
  bool get enableLogs => true;
}
