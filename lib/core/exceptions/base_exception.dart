class BaseException implements Exception {
  final String message;
  final String? details;

  BaseException(this.message, [this.details]);

  @override
  String toString() =>
      'Exception: $message${details != null ? ', Details: $details' : ''}';
}
