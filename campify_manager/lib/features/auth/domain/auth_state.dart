import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/domain/entities/user.dart';

part 'auth_state.freezed.dart';

/// Represents the authentication state of the app.
///
/// Uses freezed union types for type-safe state handling:
/// - [initial]: App is starting, checking for stored credentials
/// - [loading]: Auth operation in progress
/// - [authenticated]: User is logged in
/// - [unauthenticated]: No user logged in
/// - [error]: Authentication error occurred
@freezed
class AuthState with _$AuthState {
  /// Initial state while checking stored credentials.
  const factory AuthState.initial() = AuthStateInitial;

  /// Loading state during auth operations.
  const factory AuthState.loading() = AuthStateLoading;

  /// User is authenticated.
  const factory AuthState.authenticated(User user) = AuthStateAuthenticated;

  /// No user is logged in.
  const factory AuthState.unauthenticated() = AuthStateUnauthenticated;

  /// An error occurred during authentication.
  const factory AuthState.error(String message) = AuthStateError;
}
