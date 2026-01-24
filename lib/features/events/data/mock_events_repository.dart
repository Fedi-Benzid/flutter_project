import '../../../core/domain/entities/entities.dart';
import '../../../mock/mock_server.dart';
import '../domain/events_repository.dart';

/// Mock implementation of [EventsRepository].
class MockEventsRepository implements EventsRepository {
  final MockServer _mockServer;

  MockEventsRepository({MockServer? mockServer})
      : _mockServer = mockServer ?? MockServer.instance;

  @override
  Future<List<Event>> getEvents({String? centerId}) async {
    return _mockServer.getEvents(centerId: centerId);
  }

  @override
  Future<Event> getEvent(String id) async {
    return _mockServer.getEvent(id);
  }

  @override
  Future<Event> createEvent(Event event) async {
    return _mockServer.createEvent(event);
  }

  @override
  Future<Event> updateEvent(String id, Event event) async {
    return _mockServer.updateEvent(id, event);
  }

  @override
  Future<Event> closeEvent(String id) async {
    // Mock: just return the event as-is
    return _mockServer.getEvent(id);
  }

  @override
  Future<void> deleteEvent(String id) async {
    await _mockServer.deleteEvent(id);
  }

  @override
  Future<List<EventParticipation>> getParticipations(String eventId) async {
    return _mockServer.getEventParticipations(eventId);
  }

  @override
  Future<List<EventParticipation>> getMyParticipations() async {
    // Mock implementation returns empty list
    return [];
  }

  @override
  Future<EventParticipation> requestParticipation(String eventId, {int numberOfPersons = 1}) async {
    return _mockServer.requestParticipation(eventId);
  }

  @override
  Future<EventParticipation> updateParticipationStatus(
    String participationId,
    String eventId,
    ParticipationStatus status,
  ) async {
    return _mockServer.updateParticipationStatus(
        eventId, participationId, status);
  }

  @override
  Future<EventParticipation> updateMyParticipation(
    String participationId,
    String eventId,
    int numberOfPersons,
  ) async {
    // Mock: return a dummy participation
    return EventParticipation(
      id: participationId,
      eventId: eventId,
      userId: 'mock-user',
      userName: 'Mock User',
      numberOfPersons: numberOfPersons,
    );
  }

  @override
  Future<void> cancelParticipation(String participationId, String eventId) async {
    // Mock: do nothing
  }

  @override
  Future<EventRating> rateEvent(String eventId, int rating, String? comment) async {
    return EventRating(
      id: 'mock-rating',
      eventId: eventId,
      userId: 'mock-user',
      rating: rating,
      comment: comment,
    );
  }

  @override
  Future<List<EventRating>> getEventRatings(String eventId) async {
    return [];
  }

  @override
  Future<double?> getAverageRating(String eventId) async {
    return null;
  }
}
