import 'package:dio/dio.dart';
import '../../core/storage/secure_storage_service.dart';
import '../config/app_config.dart';
import 'api_exception.dart';

/// Base HTTP client for API requests
/// Handles authentication, error handling, and request/response interceptors
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio _dio;
  final SecureStorageService _storage = SecureStorageService.instance;

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: AppConfig.connectTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    _dio.interceptors.add(_authInterceptor());
    _dio.interceptors.add(_errorInterceptor());
    _dio.interceptors.add(_loggingInterceptor());
  }

  Dio get dio => _dio;

  /// Interceptor to add JWT token to requests
  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    );
  }

  /// Interceptor to handle errors and convert to custom exceptions
  Interceptor _errorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        final exception = _handleError(error);
        handler.reject(DioException(
          requestOptions: error.requestOptions,
          error: exception,
        ));
      },
    );
  }

  /// Interceptor for logging requests and responses (debug only)
  Interceptor _loggingInterceptor() {
    return LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
      logPrint: (obj) => print('[API] $obj'),
    );
  }

  /// Convert Dio errors to custom API exceptions
  ApiException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
            'Connection timeout. Please check your internet connection.');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = _extractErrorMessage(error.response?.data);

        if (statusCode == 401) {
          return AuthenticationException(message ?? 'Unauthorized',
              statusCode: statusCode);
        } else if (statusCode == 403) {
          return AuthorizationException(message ?? 'Forbidden');
        } else if (statusCode == 404) {
          return NotFoundException(message ?? 'Resource not found');
        } else if (statusCode == 400) {
          return ValidationException(message ?? 'Validation error',
              data: error.response?.data);
        }

        return ApiException(
          message ?? 'Server error occurred',
          statusCode: statusCode,
          data: error.response?.data,
        );

      case DioExceptionType.cancel:
        return ApiException('Request cancelled');

      case DioExceptionType.connectionError:
        return NetworkException('No internet connection');

      default:
        return ApiException('An unexpected error occurred: ${error.message}');
    }
  }

  /// Extract error message from response data
  String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    if (data is Map<String, dynamic>) {
      // Try backend's ApiResponse format
      if (data['message'] != null) {
        return data['message'] as String;
      }
      // Try common error field names
      if (data['error'] != null) {
        return data['error'] as String;
      }
      if (data['detail'] != null) {
        return data['detail'] as String;
      }
    }

    return null;
  }
}
