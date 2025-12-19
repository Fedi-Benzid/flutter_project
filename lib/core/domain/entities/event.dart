import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

/// Status of a participation request.
enum ParticipationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('declined')
  declined,
}

/// Extension methods for ParticipationStatus.
extension ParticipationStatusExtension on ParticipationStatus {
  String get displayName {
    switch (this) {
      case ParticipationStatus.pending:
        return 'Pending';
      case ParticipationStatus.approved:
        return 'Approved';
      case ParticipationStatus.declined:
        return 'Declined';
    }
  }
}

/// Event entity for forum/community events.
///
/// Events allow owners to organize camping activities at their centers.
@freezed
class Event with _$Event {
  const factory Event({
    /// Unique identifier
    required String id,

    /// ID of the center where the event takes place
    required String centerId,

    /// Event title
    required String title,

    /// Detailed description of the event
    required String description,

    /// Date and time of the event
    required DateTime date,

    /// Duration in hours
    @Default(2) int durationHours,

    /// Maximum number of participants
    @Default(20) int maxParticipants,

    /// Current number of confirmed participants
    @Default(0) int currentParticipants,

    /// Optional image URL for the event
    String? imageUrl,

    /// When the event was created
    DateTime? createdAt,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

/// Participation request for an event.
@freezed
class EventParticipation with _$EventParticipation {
  const factory EventParticipation({
    /// Unique identifier
    required String id,

    /// ID of the event
    required String eventId,

    /// ID of the user requesting to participate
    required String userId,

    /// Name of the user (denormalized for display)
    required String userName,

    /// Current status of the request
    @Default(ParticipationStatus.pending) ParticipationStatus status,

    /// Optional message from the requester
    String? message,

    /// When the request was made
    DateTime? requestedAt,
  }) = _EventParticipation;

  factory EventParticipation.fromJson(Map<String, dynamic> json) =>
      _$EventParticipationFromJson(json);
}

/// Extension for event capacity checking.
extension EventExtension on Event {
  bool get isFull => currentParticipants >= maxParticipants;
  int get spotsRemaining => maxParticipants - currentParticipants;
}
