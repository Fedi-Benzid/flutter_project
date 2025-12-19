import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';

/// Service for secure storage of authentication tokens.
///
/// Uses flutter_secure_storage to encrypt and store sensitive data
/// like auth tokens on mobile.
/// Uses SharedPreferences on Web (as secure storage is not fully supported/needed for demo).
class SecureStorageService {
  SecureStorageService._();
  static final SecureStorageService instance = SecureStorageService._();

  // Mobile storage
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  /// Save the authentication token.
  Future<void> saveToken(String token) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(StorageKeys.authToken, token);
    } else {
      await _secureStorage.write(key: StorageKeys.authToken, value: token);
    }
  }

  /// Get the stored authentication token.
  Future<String?> getToken() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(StorageKeys.authToken);
    } else {
      return await _secureStorage.read(key: StorageKeys.authToken);
    }
  }

  /// Delete the authentication token.
  Future<void> deleteToken() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(StorageKeys.authToken);
    } else {
      await _secureStorage.delete(key: StorageKeys.authToken);
    }
  }

  /// Save the refresh token.
  Future<void> saveRefreshToken(String token) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(StorageKeys.refreshToken, token);
    } else {
      await _secureStorage.write(key: StorageKeys.refreshToken, value: token);
    }
  }

  /// Get the stored refresh token.
  Future<String?> getRefreshToken() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(StorageKeys.refreshToken);
    } else {
      return await _secureStorage.read(key: StorageKeys.refreshToken);
    }
  }

  /// Delete the refresh token.
  Future<void> deleteRefreshToken() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(StorageKeys.refreshToken);
    } else {
      await _secureStorage.delete(key: StorageKeys.refreshToken);
    }
  }

  /// Save the current user's ID.
  Future<void> saveUserId(String userId) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(StorageKeys.userId, userId);
    } else {
      await _secureStorage.write(key: StorageKeys.userId, value: userId);
    }
  }

  /// Get the stored user ID.
  Future<String?> getUserId() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(StorageKeys.userId);
    } else {
      return await _secureStorage.read(key: StorageKeys.userId);
    }
  }

  /// Save the current user's role.
  Future<void> saveUserRole(String role) async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(StorageKeys.userRole, role);
    } else {
      await _secureStorage.write(key: StorageKeys.userRole, value: role);
    }
  }

  /// Get the stored user role.
  Future<String?> getUserRole() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(StorageKeys.userRole);
    } else {
      return await _secureStorage.read(key: StorageKeys.userRole);
    }
  }

  /// Check if the user is authenticated (has a token).
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear all stored credentials.
  Future<void> clearAll() async {
    if (kIsWeb) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } else {
      await _secureStorage.deleteAll();
    }
  }

  /// Save all auth data at once.
  Future<void> saveAuthData({
    required String token,
    required String userId,
    required String role,
    String? refreshToken,
  }) async {
    await saveToken(token);
    await saveUserId(userId);
    await saveUserRole(role);
    if (refreshToken != null) {
      await saveRefreshToken(refreshToken);
    }
  }
}
