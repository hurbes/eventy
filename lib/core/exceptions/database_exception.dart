class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException: $message';
}

class InitializationException extends DatabaseException {
  InitializationException(String message) : super(message);
}

class AddException extends DatabaseException {
  AddException(String message) : super(message);
}

class UpdateException extends DatabaseException {
  UpdateException(String message) : super(message);
}

class DeleteException extends DatabaseException {
  DeleteException(String message) : super(message);
}

class FetchException extends DatabaseException {
  FetchException(String message) : super(message);
}

class QueryException extends DatabaseException {
  QueryException(String message) : super(message);
}
