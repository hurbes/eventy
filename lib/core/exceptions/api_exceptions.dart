// Network-related errors
import 'base_exception.dart';

class NetworkException extends BaseException {
  NetworkException(String message, [String? details]) : super(message, details);
}

// API-related errors
class ApiException extends BaseException {
  final int? statusCode;
  ApiException(String message, [this.statusCode, String? details])
      : super(message, details);
}

// Payment errors
class PaymentException extends BaseException {
  final String paymentErrorCode;
  PaymentException(String message, this.paymentErrorCode, [String? details])
      : super(message, details);
}

// Storage errors (e.g., caching, local storage)
class StorageException extends BaseException {
  StorageException(String message, [String? details]) : super(message, details);
}

// Parsing errors (e.g., JSON parsing, localization issues)
class ParsingException extends BaseException {
  ParsingException(String message, [String? details]) : super(message, details);
}

// Authentication errors (optional)
class AuthenticationException extends BaseException {
  AuthenticationException(String message, [String? details])
      : super(message, details);
}
