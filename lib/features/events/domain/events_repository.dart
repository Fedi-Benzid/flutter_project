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

  /// Delete an event (owner only).
  Future<void> deleteEvent(String id);

  /// Get participations for an event.
  Future<List<EventParticipation>> getParticipations(String eventId);

  /// Request to participate in an event.
  Future<EventParticipation> requestParticipation(String eventId);

  /// Update participation status (owner only).
  Future<EventParticipation> updateParticipationStatus(
    String participationId,
    String eventId,
    ParticipationStatus status,
  );
}
