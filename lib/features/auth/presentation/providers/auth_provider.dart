import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/domain/entities/user.dart';
import '../../data/api_auth_repository.dart';
import '../../domain/auth_repository.dart';
import '../../domain/auth_state.dart';

/// Provider for the auth repository.
/// Now uses the real API repository instead of mock
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return ApiAuthRepository();
});

/// Provider for the current authentication state.
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

/// Provider that returns the current user if authenticated.
final currentUserProvider = Provider<User?>((ref) {
  return ref
      .watch(authStateProvider)
      .maybeWhen(authenticated: (user) => user, orElse: () => null);
});

/// Provider that returns whether the user is authenticated.
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref
      .watch(authStateProvider)
      .maybeWhen(authenticated: (_) => true, orElse: () => false);
});

/// Provider that returns whether the current user is a center owner.
final isOwnerProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.role == UserRole.owner;
});

/// State notifier for managing authentication state.
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState.initial()) {
    // Check for stored session on initialization
    _checkStoredSession();
  }

  Future<void> _checkStoredSession() async {
    state = const AuthState.loading();

    try {
      final user = await _repository.checkStoredSession();
      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      state = const AuthState.unauthenticated();
    }
  }

  /// Login with email and password.
  Future<bool> login({required String email, required String password}) async {
    state = const AuthState.loading();

    try {
      final result = await _repository.login(email: email, password: password);
      state = AuthState.authenticated(result.user);
      return true;
    } on AuthException catch (e) {
      state = AuthState.error(e.message);
      return false;
    } catch (e, st) {
      print('Login Error: $e');
      print('Stack Trace: $st');
      state = AuthState.error('Error: $e');
      return false;
    }
  }

  /// Register a new user.
  Future<bool> register({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    state = const AuthState.loading();

    try {
      final result = await _repository.register(
        email: email,
        password: password,
        name: name,
        role: role,
      );
      state = AuthState.authenticated(result.user);
      return true;
    } on AuthException catch (e) {
      state = AuthState.error(e.message);
      return false;
    } catch (e) {
      state = AuthState.error('An unexpected error occurred');
      return false;
    }
  }

  /// Logout the current user.
  Future<void> logout() async {
    state = const AuthState.loading();
    await _repository.logout();
    state = const AuthState.unauthenticated();
  }

  /// Update the current user's profile.
  Future<bool> updateProfile({
    String? name,
    String? phone,
    String? avatarUrl,
  }) async {
    // Don't change auth state while updating profile
    try {
      final updatedUser = await _repository.updateProfile(
        name: name,
        phone: phone,
        avatarUrl: avatarUrl,
      );
      state = AuthState.authenticated(updatedUser);
      return true;
    } on AuthException {
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Request a password reset.
  Future<void> resetPassword(String email) async {
    await _repository.resetPassword(email);
  }

  /// Clear any error state.
  void clearError() {
    if (state is AuthStateError) {
      state = const AuthState.unauthenticated();
    }
  }
}
