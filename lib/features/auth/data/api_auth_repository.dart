import '../../../core/domain/entities/user.dart';
import '../../../core/storage/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'auth_api_service.dart';
import '../domain/auth_repository.dart';

/// Real API implementation of [AuthRepository]
///
/// Uses [AuthApiService] for backend API calls and stores JWT tokens
class ApiAuthRepository implements AuthRepository {
  final AuthApiService _apiService;
  final SecureStorageService _storage;

  ApiAuthRepository({
    AuthApiService? apiService,
    SecureStorageService? storage,
  })  : _apiService = apiService ?? AuthApiService(),
        _storage = storage ?? SecureStorageService.instance;

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _apiService.login(email, password);

      final user = User.fromJson(result['user'] as Map<String, dynamic>);
      final token = result['token'] as String;

      // Store credentials
      await _storage.saveAuthData(
        token: token,
        userId: user.id,
        role: user.role.name,
      );

      return AuthResult(user: user, token: token);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<AuthResult> register({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    try {
      // Register the user
      await _apiService.register(
        email: email,
        password: password,
        name: name,
        role: role,
      );

      // Auto-login after registration
      return await login(email: email, password: password);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await _storage.clearAll();
  }

  @override
  Future<User?> getProfile() async {
    try {
      final userData = await _apiService.getProfile();
      return User.fromJson(userData);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<User> updateProfile({
    String? name,
    String? phone,
    String? avatarUrl,
    DateTime? createdAt,
  }) async {
    try {
      final userData = await _apiService.updateProfile(
        name: name,
        phone: phone,
        avatarUrl: avatarUrl,
        createdAt: createdAt,
      );
      return User.fromJson(userData);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<User> uploadProfileImage(List<int> bytes, String filename) async {
    try {
      final userData = await _apiService.uploadProfileImage(bytes, filename);
      return User.fromJson(userData);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    try {
      await _apiService.requestPasswordReset(email);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> verifyResetCode(String email, String code) async {
    try {
      await _apiService.verifyResetCode(email, code);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> completePasswordReset({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      await _apiService.completePasswordReset(
        email: email,
        code: code,
        newPassword: newPassword,
      );
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    await requestPasswordReset(email);
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _apiService.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  @override
  Future<User?> checkStoredSession() async {
    final token = await _storage.getToken();
    if (token == null) {
      return null;
    }

    try {
      return await getProfile();
    } catch (e) {
      // Session invalid, clear storage
      await _storage.clearAll();
      return null;
    }
  }
}
