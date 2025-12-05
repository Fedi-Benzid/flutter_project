import '../../../core/domain/entities/user.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../../../mock/mock_server.dart';
import '../domain/auth_repository.dart';

/// Mock implementation of [AuthRepository] for demo mode.
///
/// Uses [MockServer] for authentication operations.
/// Persists tokens using [SecureStorageService].
class MockAuthRepository implements AuthRepository {
  final MockServer _mockServer;
  final SecureStorageService _storage;

  MockAuthRepository({MockServer? mockServer, SecureStorageService? storage})
      : _mockServer = mockServer ?? MockServer.instance,
        _storage = storage ?? SecureStorageService.instance;

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _mockServer.login(email, password);

      final user = User.fromJson(result['user'] as Map<String, dynamic>);
      final token = result['token'] as String;

      // Store credentials
      await _storage.saveAuthData(
        token: token,
        userId: user.id,
        role: user.role.name,
      );

      // Set current user in mock server
      _mockServer.setCurrentUser(user.id, token);

      return AuthResult(user: user, token: token);
    } on MockServerException catch (e) {
      throw AuthException(e.message);
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
      final result = await _mockServer.register(
        email: email,
        password: password,
        name: name,
        role: role,
      );

      final user = User.fromJson(result['user'] as Map<String, dynamic>);
      final token = result['token'] as String;

      // Store credentials
      await _storage.saveAuthData(
        token: token,
        userId: user.id,
        role: user.role.name,
      );

      // Set current user in mock server
      _mockServer.setCurrentUser(user.id, token);

      return AuthResult(user: user, token: token);
    } on MockServerException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<void> logout() async {
    await _mockServer.logout();
    await _storage.clearAll();
    _mockServer.clearSession();
  }

  @override
  Future<User?> getProfile() async {
    try {
      return await _mockServer.getProfile();
    } on MockServerException {
      return null;
    }
  }

  @override
  Future<User> updateProfile({
    String? name,
    String? phone,
    String? avatarUrl,
  }) async {
    try {
      return await _mockServer.updateProfile(
        name: name,
        phone: phone,
        avatarUrl: avatarUrl,
      );
    } on MockServerException catch (e) {
      throw AuthException(e.message);
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    await _mockServer.resetPassword(email);
  }

  @override
  Future<User?> checkStoredSession() async {
    final token = await _storage.getToken();
    final userId = await _storage.getUserId();

    if (token == null || userId == null) {
      return null;
    }

    // Restore session in mock server
    _mockServer.setCurrentUser(userId, token);

    try {
      return await _mockServer.getProfile();
    } on MockServerException {
      // Session invalid, clear storage
      await _storage.clearAll();
      _mockServer.clearSession();
      return null;
    }
  }
}
