/// Custom exception for API-related errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() => message;
}

/// Exception for network-related errors
class NetworkException extends ApiException {
  NetworkException(super.message);
}

/// Exception for authentication errors
class AuthenticationException extends ApiException {
  AuthenticationException(super.message, {super.statusCode});
}

/// Exception for authorization errors
class AuthorizationException extends ApiException {
  AuthorizationException(super.message) : super(statusCode: 403);
}

/// Exception for not found errors
class NotFoundException extends ApiException {
  NotFoundException(super.message) : super(statusCode: 404);
}

/// Exception for validation errors
class ValidationException extends ApiException {
  ValidationException(super.message, {super.data}) : super(statusCode: 400);
}
