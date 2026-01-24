import '../../../core/domain/entities/entities.dart';

/// Abstract repository interface for events operations.
abstract class EventsRepository {
  /// Get all events.
  Future<List<Event>> getEvents({String? centerId});

  /// Get a single event by ID.
  Future<Event> getEvent(String id);

  /// Create a new event (owner only).
  Future<Event> createEvent(Event event);

  /// Update an event (owner only).
  Future<Event> updateEvent(String id, Event event);

  /// Close an event (owner only).
  Future<Event> closeEvent(String id);

  /// Delete an event (owner only).
  Future<void> deleteEvent(String id);

  /// Get participations for an event.
  Future<List<EventParticipation>> getParticipations(String eventId);

  /// Get the current user's participations across all events.
  Future<List<EventParticipation>> getMyParticipations();

  /// Request to participate in an event.
  Future<EventParticipation> requestParticipation(String eventId, {int numberOfPersons = 1});

  /// Update participation status (owner only).
  Future<EventParticipation> updateParticipationStatus(
    String participationId,
    String eventId,
    ParticipationStatus status,
  );

  /// Update my participation request (camper only, when pending).
  Future<EventParticipation> updateMyParticipation(
    String participationId,
    String eventId,
    int numberOfPersons,
  );

  /// Cancel my participation request (camper only).
  Future<void> cancelParticipation(String participationId, String eventId);

  /// Rate an event (participant only, after event ends).
  Future<EventRating> rateEvent(String eventId, int rating, String? comment);

  /// Get ratings for an event.
  Future<List<EventRating>> getEventRatings(String eventId);

  /// Get average rating for an event.
  Future<double?> getAverageRating(String eventId);
}
