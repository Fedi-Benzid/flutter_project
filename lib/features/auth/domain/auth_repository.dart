import '../../../core/domain/entities/user.dart';

/// Abstract repository interface for authentication operations.
///
/// This interface defines the contract for authentication services.
/// Implement this interface to create:
/// - [MockAuthRepository] for demo mode
/// - Real API implementation for production
///
/// All methods throw exceptions on failure, which should be caught
/// and handled by the presentation layer.
abstract class AuthRepository {
  /// Login with email and password.
  ///
  /// Returns [AuthResult] containing user and token on success.
  /// Throws exception on invalid credentials.
  Future<AuthResult> login({required String email, required String password});

  /// Register a new user.
  ///
  /// [role] determines if registering as camper or owner.
  /// Returns [AuthResult] containing new user and token on success.
  /// Throws exception if email already exists.
  Future<AuthResult> register({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  });

  /// Logout the current user.
  ///
  /// Clears stored credentials and session.
  Future<void> logout();

  /// Get the current authenticated user's profile.
  ///
  /// Returns null if not authenticated.
  Future<User?> getProfile();

  /// Update the current user's profile.
  ///
  /// Only provided fields will be updated.
  Future<User> updateProfile({String? name, String? phone, String? avatarUrl});

  /// Request a password reset email.
  ///
  /// Always succeeds (doesn't reveal if email exists).
  Future<void> resetPassword(String email);

  /// Check if there's a stored session and restore it.
  ///
  /// Returns the authenticated user if session is valid.
  Future<User?> checkStoredSession();
}

/// Result of a successful authentication operation.
class AuthResult {
  final User user;
  final String token;

  const AuthResult({required this.user, required this.token});
}

/// Exception thrown by authentication operations.
class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() => message;
}
