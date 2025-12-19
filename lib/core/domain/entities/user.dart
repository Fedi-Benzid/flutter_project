import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User role enum for role-based access control.
/// - [camper]: Regular user who can browse centers, make reservations, join events
/// - [owner]: Center owner who can manage centers, approve reservations, create items
enum UserRole {
  @JsonValue('camper')
  camper,
  @JsonValue('owner')
  owner,
}

/// User entity representing a registered user in the system.
///
/// This is the core user model used throughout the application for:
/// - Authentication and authorization
/// - Profile display and management
/// - Ownership tracking for centers, reservations, and events
@freezed
class User with _$User {
  const factory User({
    /// Unique identifier for the user
    required String id,

    /// User's email address (used for login)
    required String email,

    /// User's display name
    required String name,

    /// User's role determining access permissions
    required UserRole role,

    /// Optional phone number for contact
    String? phone,

    /// URL to user's profile photo
    String? avatarUrl,

    /// When the user account was created
    DateTime? createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
