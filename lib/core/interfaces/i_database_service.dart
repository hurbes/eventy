abstract class IDatabaseService {
  /// Adds an object to the database.
  Future<void> add<T>(T object);

  /// Updates an existing object in the database.
  Future<void> update<T>(T object);

  /// Deletes an object from the database.
  Future<void> delete<T>(T object);

  /// Fetches all objects of type T from the database.
  Future<List<T>> fetchAll<T>();

  /// Fetches an object by its integer ID.
  Future<T?> fetchById<T>(int id);

  /// Executes a query and returns a list of objects.
  Future<List<T>> query<T>(String query);

  /// Provides a stream of query results that updates when changes occur.
  Stream<List<T>> queryStream<T>(String query);

  Future<void> clearAll<T>();
}
