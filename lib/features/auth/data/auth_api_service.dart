import 'package:dio/dio.dart';
import '../../../config/app_config.dart';
import '../../../core/domain/entities/user.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';

/// API service for authentication operations
class AuthApiService {
  final Dio _dio = ApiClient().dio;

  /// Login with email and password
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '${AppConfig.authPath}/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      // Extract from ApiResponse wrapper
      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        final data = apiResponse['data'] as Map<String, dynamic>;
        final userData = data['user'] as Map<String, dynamic>;

        // Transform backend user data to Flutter format
        final transformedUser = _transformUserData(userData);

        return {
          'token': data['accessToken'] as String,
          'user': transformedUser,
        };
      }

      throw ApiException(apiResponse['message'] ?? 'Login failed');
    } on DioException catch (e) {
      if (e.error is ApiException) {
        rethrow;
      }
      throw ApiException('Login failed: ${e.message}');
    }
  }

  /// Register a new user
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required UserRole role,
    String? phone,
  }) async {
    try {
      // Split name into firstName and lastName
      final nameParts = name.trim().split(' ');
      final firstName = nameParts.first;
      final lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

      final data = <String, dynamic>{
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'role': role == UserRole.owner ? 'OWNER' : 'USER',
      };

      // Add phone number if provided
      if (phone != null && phone.isNotEmpty) {
        data['phoneNumber'] = phone;
      }

      final response = await _dio.post(
        '${AppConfig.authPath}/register',
        data: data,
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] != true) {
        throw ApiException(apiResponse['message'] ?? 'Registration failed');
      }
    } on DioException catch (e) {
      if (e.error is ApiException) {
        rethrow;
      }
      throw ApiException('Registration failed: ${e.message}');
    }
  }

  /// Get current user profile
  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _dio.get('${AppConfig.authPath}/profile');

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        final userData = apiResponse['data'] as Map<String, dynamic>;
        return _transformUserData(userData);
      }

      throw ApiException(apiResponse['message'] ?? 'Failed to get profile');
    } on DioException catch (e) {
      if (e.error is ApiException) {
        rethrow;
      }
      throw ApiException('Failed to get profile: ${e.message}');
    }
  }

  /// Update user profile
  Future<Map<String, dynamic>> updateProfile({
    String? name,
    String? phone,
    String? avatarUrl,
    DateTime? createdAt,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (phone != null) data['phoneNumber'] = phone;
      if (avatarUrl != null) data['avatarUrl'] = avatarUrl;
      if (createdAt != null) data['createdAt'] = createdAt.toIso8601String();

      final response = await _dio.put(
        '${AppConfig.authPath}/profile',
        data: data,
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        final userData = apiResponse['data'] as Map<String, dynamic>;
        return _transformUserData(userData);
      }

      throw ApiException(apiResponse['message'] ?? 'Failed to update profile');
    } on DioException catch (e) {
      if (e.error is ApiException) {
        rethrow;
      }
      throw ApiException('Failed to update profile: ${e.message}');
    }
  }

  /// Upload profile image
  Future<Map<String, dynamic>> uploadProfileImage(List<int> bytes, String filename) async {
    try {
      final formData = FormData.fromMap({
        'image': MultipartFile.fromBytes(
          bytes,
          filename: filename,
        ),
      });

      final response = await _dio.post(
        '${AppConfig.authPath}/profile/image',
        data: formData,
      );

      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] == true && apiResponse['data'] != null) {
        return _transformUserData(apiResponse['data']);
      }

      throw ApiException(apiResponse['message'] ?? 'Failed to upload image');
    } on DioException catch (e) {
      if (e.error is ApiException) {
        rethrow;
      }
      throw ApiException('Failed to upload image: ${e.message}');
    }
  }

  /// Request password reset code
  Future<void> requestPasswordReset(String email) async {
    try {
      await _dio.post(
        '${AppConfig.authPath}/reset-password-request',
        data: {'email': email},
      );
    } on DioException catch (e) {
      if (e.response?.data != null) {
        try {
          final errorData = e.response!.data as Map<String, dynamic>;
          final message = errorData['message'] as String?;
          if (message != null && message.isNotEmpty) {
            throw ApiException(message);
          }
        } catch (_) {}
      }
      throw ApiException('Failed to request reset code');
    }
  }

  /// Verify reset code
  Future<void> verifyResetCode(String email, String code) async {
    try {
      final response = await _dio.post(
        '${AppConfig.authPath}/verify-reset-code',
        data: {
          'email': email,
          'code': code,
        },
      );
      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] != true) {
        throw ApiException(apiResponse['message'] ?? 'Invalid code');
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        try {
          final errorData = e.response!.data as Map<String, dynamic>;
          final message = errorData['message'] as String?;
          if (message != null && message.isNotEmpty) {
            throw ApiException(message);
          }
        } catch (_) {}
      }
      throw ApiException('Failed to verify code');
    }
  }

  /// Complete password reset
  Future<void> completePasswordReset({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConfig.authPath}/reset-password',
        data: {
          'email': email,
          'code': code,
          'newPassword': newPassword,
        },
      );
      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] != true) {
        throw ApiException(apiResponse['message'] ?? 'Failed to reset password');
      }
    } on DioException catch (e) {
      if (e.response?.data != null) {
        try {
          final errorData = e.response!.data as Map<String, dynamic>;
          final message = errorData['message'] as String?;
          if (message != null && message.isNotEmpty) {
            throw ApiException(message);
          }
        } catch (_) {}
      }
      throw ApiException('Failed to reset password');
    }
  }

  /// Request password reset (deprecated - keeping for compatibility if needed)
  Future<void> resetPassword(String email) async {
    await requestPasswordReset(email);
  }

  /// Change password for authenticated user
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _dio.post(
        '${AppConfig.authPath}/change-password',
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        },
      );
      final apiResponse = response.data as Map<String, dynamic>;
      if (apiResponse['success'] != true) {
        throw ApiException(apiResponse['message'] ?? 'Failed to change password');
      }
    } on DioException catch (e) {
      if (e.error is ApiException) {
        rethrow;
      }
      // Try to extract error message from response
      if (e.response?.data != null) {
        try {
          final errorData = e.response!.data as Map<String, dynamic>;
          final message = errorData['message'] as String?;
          if (message != null && message.isNotEmpty) {
            throw ApiException(message);
          }
        } catch (_) {
          // Ignore parsing errors and use default message
        }
      }
      // Provide user-friendly error messages
      if (e.response?.statusCode == 400) {
        throw ApiException('Invalid current password');
      } else if (e.response?.statusCode == 401) {
        throw ApiException('Session expired. Please login again.');
      } else {
        throw ApiException('Failed to change password. Please try again.');
      }
    }
  }

  /// Transform backend user data to Flutter format
  /// - Converts id from int to String
  /// - Combines firstName and lastName into name
  /// - Maps role from backend format (USER/OWNER) to Flutter format (camper/owner)
  Map<String, dynamic> _transformUserData(Map<String, dynamic> backendUser) {
    final id = backendUser['id'];
    final firstName = backendUser['firstName'] as String? ?? '';
    final lastName = backendUser['lastName'] as String? ?? '';
    final name = backendUser['name'] as String? ?? '$firstName $lastName'.trim();
    final role = backendUser['role'] as String?;

    // Map backend role to Flutter role
    String flutterRole = 'camper';
    if (role == 'OWNER' || role == 'owner') {
      flutterRole = 'owner';
    }

    return {
      'id': id.toString(), // Convert int to String
      'email': backendUser['email'],
      'name': name.isNotEmpty ? name : firstName,
      'role': flutterRole,
      'phone': backendUser['phoneNumber'],
      'avatarUrl': backendUser['avatarUrl'],
      'createdAt': backendUser['createdAt'],
    };
  }
}
