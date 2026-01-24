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
    final eventData = _eventToJson(event);
    final data = await _apiService.createEvent(eventData);
    return _transformEvent(data);
  }

  @override
  Future<Event> updateEvent(String id, Event event) async {
    final eventData = _eventToJson(event);
    final data = await _apiService.updateEvent(id, eventData);
    return _transformEvent(data);
  }

  @override
  Future<Event> closeEvent(String id) async {
    final data = await _apiService.closeEvent(id);
    return _transformEvent(data);
  }

  @override
  Future<void> deleteEvent(String id) async {
    await _apiService.deleteEvent(id);
  }

  Map<String, dynamic> _eventToJson(Event event) {
    return {
      'title': event.title,
      'description': event.description,
      'centerId': int.tryParse(event.centerId) ?? 0,
      'startDate': event.date.toIso8601String(),
      'endDate': event.date
          .add(Duration(hours: event.durationHours))
          .toIso8601String(),
      'maxParticipants': event.maxParticipants,
      if (event.imageUrl != null) 'imageUrl': event.imageUrl,
      if (event.price > 0) 'price': event.price,
      if (event.activities.isNotEmpty) 'activities': event.activities.join(','),
      if (event.location != null) 'location': event.location,
      'isClosed': event.isClosed,
    };
  }

  @override
  Future<List<EventParticipation>> getParticipations(String eventId) async {
    final data = await _apiService.getEventParticipations(eventId);
    return data.map((json) => _transformParticipation(json)).toList();
  }

  @override
  Future<List<EventParticipation>> getMyParticipations() async {
    final data = await _apiService.getUserParticipations();
    return data.map((json) => _transformParticipation(json)).toList();
  }

  @override
  Future<EventParticipation> requestParticipation(String eventId, {int numberOfPersons = 1}) async {
    final data = await _apiService.joinEvent(eventId, numberOfPersons: numberOfPersons);
    return _transformParticipation(data);
  }

  @override
  Future<EventParticipation> updateParticipationStatus(
    String participationId,
    String eventId,
    ParticipationStatus status,
  ) async {
    final statusStr = _statusToBackend(status);
    final data = await _apiService.updateParticipationStatus(
        eventId, participationId, statusStr);
    return _transformParticipation(data);
  }

  @override
  Future<EventParticipation> updateMyParticipation(
    String participationId,
    String eventId,
    int numberOfPersons,
  ) async {
    final data = await _apiService.updateMyParticipation(
        eventId, participationId, numberOfPersons);
    return _transformParticipation(data);
  }

  @override
  Future<void> cancelParticipation(String participationId, String eventId) async {
    await _apiService.cancelParticipation(eventId, participationId);
  }

  @override
  Future<EventRating> rateEvent(String eventId, int rating, String? comment) async {
    final data = await _apiService.rateEvent(eventId, rating, comment);
    return _transformRating(data);
  }

  @override
  Future<List<EventRating>> getEventRatings(String eventId) async {
    final data = await _apiService.getEventRatings(eventId);
    return data.map((json) => _transformRating(json)).toList();
  }

  @override
  Future<double?> getAverageRating(String eventId) async {
    return await _apiService.getAverageRating(eventId);
  }

  String _statusToBackend(ParticipationStatus status) {
    switch (status) {
      case ParticipationStatus.approved:
        return 'APPROVED';
      case ParticipationStatus.declined:
        return 'REJECTED';
      case ParticipationStatus.pending:
        return 'PENDING';
    }
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

    // Parse activities list - handle both array and comma-separated string
    List<String> activities = [];
    if (json['activities'] != null) {
      if (json['activities'] is List) {
        activities = (json['activities'] as List).map((e) => e.toString()).toList();
      } else if (json['activities'] is String) {
        activities = (json['activities'] as String).split(',').where((s) => s.isNotEmpty).toList();
      }
    }

    return Event(
      id: json['id'].toString(),
      centerId: json['centerId']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      date: startDate,
      endDate: endDate,
      durationHours: durationHours > 0 ? durationHours : 2,
      maxParticipants: json['maxParticipants'] as int? ?? 0,
      currentParticipants: json['currentParticipants'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String?,
      location: json['location'] as String?,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      activities: activities,
      creatorId: json['ownerId']?.toString(),
      creatorPhone: json['creatorPhone'] as String?,
      centerName: json['centerName'] as String?,
      ownerFirstName: json['ownerFirstName'] as String?,
      ownerLastName: json['ownerLastName'] as String?,
      ownerPhoneNumber: json['ownerPhoneNumber'] as String?,
      isClosed: json['isClosed'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  EventParticipation _transformParticipation(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>?;

    String userName = 'Unknown';
    String? phoneNumber;
    String? userEmail;

    if (userJson != null) {
      final firstName = userJson['firstName'] as String? ?? '';
      final lastName = userJson['lastName'] as String? ?? '';
      userName = '$firstName $lastName'.trim();
      if (userName.isEmpty) {
        userName = userJson['email'] as String? ?? 'Unknown';
      }
      phoneNumber = userJson['phoneNumber'] as String?;
      userEmail = userJson['email'] as String?;
    }

    return EventParticipation(
      id: json['id'].toString(),
      eventId: json['eventId'].toString(),
      userId: json['userId'].toString(),
      userName: userName,
      phoneNumber: phoneNumber,
      userEmail: userEmail,
      numberOfPersons: json['numberOfPersons'] as int? ?? 1,
      status: _parseParticipationStatus(json['status'] as String?),
      requestedAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  EventRating _transformRating(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>?;
    String? userName;

    if (userJson != null) {
      final firstName = userJson['firstName'] as String? ?? '';
      final lastName = userJson['lastName'] as String? ?? '';
      userName = '$firstName $lastName'.trim();
      if (userName.isEmpty) {
        userName = userJson['email'] as String?;
      }
    }

    return EventRating(
      id: json['id'].toString(),
      eventId: json['eventId'].toString(),
      userId: json['userId'].toString(),
      userName: userName,
      rating: json['rating'] as int? ?? 0,
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  ParticipationStatus _parseParticipationStatus(String? status) {
    switch (status) {
      case 'APPROVED':
        return ParticipationStatus.approved;
      case 'REJECTED':
        return ParticipationStatus.declined;
      default:
        return ParticipationStatus.pending;
    }
  }
}
