import 'events_api_service.dart';
import '../domain/events_repository.dart';
import '../../../core/domain/entities/entities.dart';

/// Real API implementation of [EventsRepository]
class ApiEventsRepository implements EventsRepository {
  final EventsApiService _apiService;

  ApiEventsRepository({EventsApiService? apiService})
      : _apiService = apiService ?? EventsApiService();

  @override
  Future<List<Event>> getEvents({String? centerId}) async {
    final data = await _apiService.getEvents(centerId: centerId);
    return data.map((json) => _transformEvent(json)).toList();
  }

  @override
  Future<Event> getEvent(String id) async {
    final data = await _apiService.getEvent(id);
    return _transformEvent(data);
  }

  @override
  Future<Event> createEvent(Event event) async {
    throw UnimplementedError('Create event not yet implemented');
  }

  @override
  Future<Event> updateEvent(String id, Event event) async {
    throw UnimplementedError('Update event not yet implemented');
  }

  @override
  Future<void> deleteEvent(String id) async {
    throw UnimplementedError('Delete event not yet implemented');
  }

  @override
  Future<List<EventParticipation>> getParticipations(String eventId) async {
    throw UnimplementedError('Get participations not yet implemented');
  }

  @override
  Future<EventParticipation> requestParticipation(String eventId) async {
    await _apiService.joinEvent(eventId);
    // Return a placeholder since the API doesn't return the participation object
    return EventParticipation(
      id: '',
      eventId: eventId,
      userId: '',
      userName: '',
      status: ParticipationStatus.pending,
    );
  }

  @override
  Future<EventParticipation> updateParticipationStatus(
    String participationId,
    String eventId,
    ParticipationStatus status,
  ) async {
    throw UnimplementedError('Update participation status not yet implemented');
  }

  Event _transformEvent(Map<String, dynamic> json) {
    final startDate = json['startDate'] != null
        ? DateTime.parse(json['startDate'])
        : DateTime.now();
    final endDate = json['endDate'] != null
        ? DateTime.parse(json['endDate'])
        : startDate.add(const Duration(hours: 2));

    // Calculate duration in hours
    final durationHours = endDate.difference(startDate).inHours;

    return Event(
      id: json['id'].toString(),
      centerId: json['centerId']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      date: startDate,
      durationHours: durationHours > 0 ? durationHours : 2,
      maxParticipants: json['maxParticipants'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}
